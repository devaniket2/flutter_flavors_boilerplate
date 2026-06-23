import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import 'package:flutter_flavors_boilerplate/app/common/themes/text_theme/app_text_theme.dart';
import 'package:flutter_flavors_boilerplate/app/resources/color_resource.dart';
import 'package:flutter_flavors_boilerplate/app/resources/string_resource.dart';
import 'package:flutter_flavors_boilerplate/features/app_webview/presentation/cubit/app_webview.state.dart';
import 'package:flutter_flavors_boilerplate/features/app_webview/presentation/cubit/app_webview_cubit.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppWebviewScreen extends StatefulWidget {
  const AppWebviewScreen({super.key});

  @override
  State<AppWebviewScreen> createState() => _AppWebviewScreenState();
}

class _AppWebviewScreenState extends State<AppWebviewScreen>
    with SingleTickerProviderStateMixin {
  final String _baseUri = "https://www.google.com/search?q=wuthering waves";

  late InAppWebViewController _webViewController;
  final _appbarAnimationDuration = const Duration(milliseconds: 250);

  bool get isDarkMode => Theme.of(context).brightness == Brightness.dark;
  final double iconSize = 14.sp;

  late Animation<double> _appbarAnimation;
  late final Animation<double> _webpageAnimation;
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: _appbarAnimationDuration,
      reverseDuration: _appbarAnimationDuration,
    );

    _webpageAnimation = Tween<double>(begin: 60.h, end: 0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.fastEaseInToSlowEaseOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _appbarAnimation =
        Tween<double>(
          begin: 0.0,
          end: -(60.h + MediaQuery.paddingOf(context).top).toDouble(),
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.fastEaseInToSlowEaseOut,
          ),
        );

    return BlocProvider(
      create: (context) => AppWebviewCubit(),
      // No more top-level BlocBuilder!
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              // -------------------------------------------------------------
              // WEBVIEW LAYER (Now entirely static, won't rebuild on progress)
              // -------------------------------------------------------------
              Positioned.fill(
                child: AnimatedBuilder(
                  animation: _appbarAnimation,
                  builder: (_, child) => Transform.translate(
                    offset: Offset(0, _webpageAnimation.value),
                    child: child,
                  ),
                  child: Builder(
                    // Used to get an inner context below BlocProvider
                    builder: (innerContext) {
                      return InAppWebView(
                        initialSettings: InAppWebViewSettings(
                          forceDark: isDarkMode ? ForceDark.ON : ForceDark.OFF,
                        ),
                        initialUrlRequest: URLRequest(url: WebUri(_baseUri)),
                        onWebViewCreated: (controller) {
                          _webViewController = controller;
                        },
                        onProgressChanged: (controller, progress) {
                          innerContext
                              .read<AppWebviewCubit>()
                              .updateLoadingPercentage(progress.toDouble());
                        },
                        onTitleChanged: (controller, title) {
                          innerContext.read<AppWebviewCubit>().updateTitle(
                            title ?? '',
                          );
                        },
                        onLoadStop: (controller, url) async {
                          bool canGoBack = await _webViewController.canGoBack();
                          bool canGoForward = await _webViewController
                              .canGoForward();

                          if (innerContext.mounted) {
                            innerContext
                                .read<AppWebviewCubit>()
                                .updateCanGoBack(canGoBack);
                            innerContext
                                .read<AppWebviewCubit>()
                                .updateCanGoFoward(canGoForward);
                          }
                        },
                        onLongPressHitTestResult:
                            (controller, hitTestResult) async {
                              if (hitTestResult.type ==
                                      InAppWebViewHitTestResultType
                                          .IMAGE_TYPE ||
                                  hitTestResult.type ==
                                      InAppWebViewHitTestResultType
                                          .SRC_IMAGE_ANCHOR_TYPE) {
                                String? imageUrl = hitTestResult.extra;
                                if (imageUrl != null) {
                                  _showDownloadDialog(innerContext, imageUrl);
                                }
                              }
                            },
                        onScrollChanged: (_, x, y) {
                          if (y > 300) {
                            _animationController.forward();
                          } else {
                            _animationController.reverse();
                          }
                        },
                      );
                    },
                  ),
                ),
              ),

              // -------------------------------------------------------------
              // TOP APP BAR LAYER
              // -------------------------------------------------------------
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: AnimatedBuilder(
                  animation: _appbarAnimation,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, _appbarAnimation.value),
                      child: child,
                    );
                  },
                  child: Container(
                    height: 60.h,
                    width: 1.sw,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Theme.of(context).canvasColor,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: Row(
                        children: [
                          // 1. Selector for Back Button
                          BlocSelector<AppWebviewCubit, AppWebviewState, bool>(
                            selector: (state) => state.canGoBack,
                            builder: (context, canGoBack) {
                              return AnimatedSwitcher(
                                duration: _appbarAnimationDuration,
                                transitionBuilder: (child, animation) =>
                                    FadeTransition(
                                      opacity: animation,
                                      child: SizeTransition(
                                        sizeFactor: animation,
                                        axis: Axis.horizontal,
                                        child: child,
                                      ),
                                    ),
                                child: canGoBack
                                    ? IconButton(
                                        key: const ValueKey('back_button'),
                                        onPressed: () async {
                                          if (await _webViewController
                                              .canGoBack()) {
                                            _webViewController.goBack();
                                          }
                                        },
                                        icon: Icon(
                                          Icons.arrow_back_ios_new_outlined,
                                          size: iconSize,
                                        ),
                                      )
                                    : const SizedBox(
                                        key: ValueKey('empty'),
                                        width: 0,
                                      ),
                              );
                            },
                          ),

                          // 2. Selector for Forward Button
                          BlocSelector<AppWebviewCubit, AppWebviewState, bool>(
                            selector: (state) => state.canGoForward,
                            builder: (context, canGoForward) {
                              return AnimatedSwitcher(
                                duration: _appbarAnimationDuration,
                                transitionBuilder: (child, animation) =>
                                    FadeTransition(
                                      opacity: animation,
                                      child: SizeTransition(
                                        sizeFactor: animation,
                                        axis: Axis.horizontal,
                                        child: child,
                                      ),
                                    ),
                                child: canGoForward
                                    ? IconButton(
                                        key: const ValueKey('forward_button'),
                                        onPressed: () async {
                                          if (await _webViewController
                                              .canGoForward()) {
                                            _webViewController.goForward();
                                          }
                                        },
                                        icon: Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          size: iconSize,
                                        ),
                                      )
                                    : const SizedBox(
                                        key: ValueKey('empty_forward'),
                                        width: 0,
                                      ),
                              );
                            },
                          ),

                          SizedBox(width: 8.w),

                          // 3. Selector for the Title
                          Expanded(
                            child:
                                BlocSelector<
                                  AppWebviewCubit,
                                  AppWebviewState,
                                  String
                                >(
                                  selector: (state) => state.title,
                                  builder: (context, title) {
                                    final displayTitle = title.isEmpty
                                        ? StringResource.APP_TITLE
                                        : title;
                                    return AnimatedSize(
                                      duration: _appbarAnimationDuration,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 4.h,
                                          horizontal: 12.w,
                                        ),
                                        decoration: BoxDecoration(
                                          color: isDarkMode
                                              ? ColorResource
                                                    .CANVAS_DARK_SECONDARY
                                              : ColorResource
                                                    .CANVAS_LIGHT_SECONDARY,
                                          borderRadius: BorderRadius.circular(
                                            12.r,
                                          ),
                                        ),
                                        child: AnimatedSwitcher(
                                          duration: _appbarAnimationDuration,
                                          transitionBuilder:
                                              (child, animation) =>
                                                  FadeTransition(
                                                    opacity: animation,
                                                    child: child,
                                                  ),
                                          child: Text(
                                            displayTitle,
                                            key: ValueKey(displayTitle),
                                            overflow: TextOverflow.clip,
                                            maxLines: 1,
                                            textAlign: TextAlign.center,
                                            style:
                                                AppTextTheme.bodySmall(
                                                  context,
                                                ).copyWith(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                          ),

                          // 4. Selector for Refresh / Close Action Button
                          BlocSelector<
                            AppWebviewCubit,
                            AppWebviewState,
                            double
                          >(
                            selector: (state) => state.loadingPercentage,
                            builder: (context, loadingPercentage) {
                              final isLoading = loadingPercentage != 100;
                              return IconButton(
                                onPressed: () async {
                                  if (isLoading) {
                                    _webViewController.stopLoading();
                                  } else {
                                    _webViewController.reload();
                                  }
                                },
                                icon: AnimatedSwitcher(
                                  duration: _appbarAnimationDuration,
                                  transitionBuilder: (child, animation) =>
                                      ScaleTransition(
                                        scale: animation,
                                        child: child,
                                      ),
                                  child: FaIcon(
                                    isLoading
                                        ? FontAwesomeIcons.xmark
                                        : FontAwesomeIcons.arrowsRotate,
                                    size: iconSize,
                                    key: ValueKey<bool>(isLoading),
                                  ),
                                ),
                              );
                            },
                          ),

                          // Home Button (Static)
                          IconButton(
                            onPressed: () async {
                              await _webViewController.clearHistory();
                              _webViewController.loadUrl(
                                urlRequest: URLRequest(url: WebUri(_baseUri)),
                              );
                            },
                            icon: FaIcon(
                              FontAwesomeIcons.house,
                              size: iconSize,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Bottom sheet and download methods remain identical...
  void _showDownloadDialog(BuildContext context, String url) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.network(url),
          ListTile(
            leading: const Icon(Icons.download),
            title: const Text("Save Image"),
            onTap: () async {
              Navigator.pop(context);
              await _downloadImage(url);
            },
          ),
        ],
      ),
    );
  }

  Future<void> _downloadImage(String url) async {
    print("Downloading: $url");
  }
}
