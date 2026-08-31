import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import 'package:flutter_flavors_boilerplate/app/common/themes/text_theme/app_text_theme.dart';
import 'package:flutter_flavors_boilerplate/app/resources/color_resource.dart';
import 'package:flutter_flavors_boilerplate/app/resources/string_resource.dart';
import 'package:flutter_flavors_boilerplate/core/di/app_dependency_manager.dart';
import 'package:flutter_flavors_boilerplate/features/app_webview/cubit/app_webview.state.dart';
import 'package:flutter_flavors_boilerplate/features/app_webview/cubit/app_webview_cubit.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppWebviewScreen extends StatelessWidget {
  const AppWebviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AppDependencyManager.dependency<AppWebviewCubit>(),
      child: const AppWebviewView(),
    );
  }
}

class AppWebviewView extends StatefulWidget {
  const AppWebviewView({super.key});

  @override
  State<AppWebviewView> createState() => _AppWebviewViewState();
}

class _AppWebviewViewState extends State<AppWebviewView>
    with SingleTickerProviderStateMixin {
  final String _baseUri = "https://www.google.com/search?q=wuthering waves";

  late InAppWebViewController _webViewController;
  final _appbarAnimationDuration = const Duration(milliseconds: 250);
  bool get isDarkMode => Theme.of(context).brightness == Brightness.dark;
  final double iconSize = 14.sp;
  late final double appBarHeight = 80.h;

  int _lastValidY = 0;
  late final AnimationController _appBarController;
  late final Animation<double> _appBarSlideAnimation;
  late final Animation<double> _webViewTranslateAnimation;

  @override
  void initState() {
    super.initState();
    _appBarController = AnimationController(
      vsync: this,
      duration: _appbarAnimationDuration,
    )..value = 1.0; // Starts fully visible

    _appBarSlideAnimation = Tween<double>(begin: -1.0, end: 0.0).animate(
      CurvedAnimation(parent: _appBarController, curve: Curves.easeInOut),
    );

    _webViewTranslateAnimation = Tween<double>(begin: 0.0, end: appBarHeight)
        .animate(
          CurvedAnimation(parent: _appBarController, curve: Curves.easeInOut),
        );
  }

  @override
  void dispose() {
    _appBarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          // -------------------------------------------------------------
          // WEBVIEW LAYER
          // -------------------------------------------------------------
          AnimatedBuilder(
            animation: _webViewTranslateAnimation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, _webViewTranslateAnimation.value),
                child: child!,
              );
            },
            child: InAppWebView(
              initialSettings: InAppWebViewSettings(
                algorithmicDarkeningAllowed: isDarkMode,
              ),
              initialUrlRequest: URLRequest(url: WebUri(_baseUri)),
              onWebViewCreated: (controller) {
                _webViewController = controller;
              },
              onProgressChanged: (controller, progress) {
                context.read<AppWebviewCubit>().updateLoadingPercentage(
                  progress.toDouble(),
                );
              },
              onTitleChanged: (controller, title) {
                context.read<AppWebviewCubit>().updateTitle(title ?? '');
              },
              onLoadStop: (controller, url) async {
                bool canGoBack = await _webViewController.canGoBack();
                bool canGoForward = await _webViewController.canGoForward();

                if (context.mounted) {
                  context.read<AppWebviewCubit>().updateCanGoBack(canGoBack);
                  context.read<AppWebviewCubit>().updateCanGoFoward(
                    canGoForward,
                  );
                }
              },
              onLongPressHitTestResult: (controller, hitTestResult) async {
                if (hitTestResult.type ==
                        InAppWebViewHitTestResultType.IMAGE_TYPE ||
                    hitTestResult.type ==
                        InAppWebViewHitTestResultType.SRC_IMAGE_ANCHOR_TYPE) {
                  String? imageUrl = hitTestResult.extra;
                  if (imageUrl != null) {
                    _showDownloadDialog(context, imageUrl);
                  }
                }
              },
              onScrollChanged: (_, x, y) {
                // 1. Force fully visible at the top edge
                if (y <= 15) {
                  if (!_appBarController.isCompleted) {
                    _appBarController.forward();
                  }
                  _lastValidY = y;
                  return;
                }

                // 2. Ignore minor micro-movements (require 12px change to trigger)
                final delta = y - _lastValidY;
                if (delta.abs() < 12) return;

                // 3. Prevent reversing mid-animation (stops jittering/jumping)
                if (_appBarController.isAnimating) return;

                _lastValidY = y;

                // 4. Trigger direction change safely
                if (delta > 0) {
                  if (_appBarController.isCompleted) {
                    _appBarController.reverse();
                  }
                } else {
                  if (_appBarController.isDismissed) {
                    _appBarController.forward();
                  }
                }
              },
            ),
          ),

          // -------------------------------------------------------------
          // TOP APP BAR LAYER
          // -------------------------------------------------------------
          AnimatedBuilder(
            animation: _appBarSlideAnimation,
            builder: (context, child) {
              return FractionalTranslation(
                translation: Offset(0, _appBarSlideAnimation.value),
                child: child,
              );
            },
            child: Container(
              height: appBarHeight,
              width: 1.sw,
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(color: Theme.of(context).canvasColor),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Row(
                  children: [
                    BlocSelector<AppWebviewCubit, AppWebviewState, bool>(
                      selector: (state) => state.canGoBack,
                      builder: (context, canGoBack) {
                        return Align(
                          alignment: Alignment.center,
                          child: AnimatedSwitcher(
                            duration: _appbarAnimationDuration,
                            transitionBuilder: (child, animation) {
                              return FadeTransition(
                                opacity: animation,
                                child: SizeTransition(
                                  sizeFactor: animation,
                                  child: child,
                                ),
                              );
                            },
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
                                : const SizedBox.shrink(
                                    key: ValueKey('empty_back'),
                                  ),
                          ),
                        );
                      },
                    ),
                    BlocSelector<AppWebviewCubit, AppWebviewState, bool>(
                      selector: (state) => state.canGoForward,
                      builder: (context, canGoForward) {
                        return Align(
                          alignment: Alignment.center,
                          child: AnimatedSwitcher(
                            duration: _appbarAnimationDuration,
                            transitionBuilder: (child, animation) {
                              return FadeTransition(
                                opacity: animation,
                                child: SizeTransition(
                                  sizeFactor: animation,
                                  child: child,
                                ),
                              );
                            },
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
                                : const SizedBox.shrink(
                                    key: ValueKey('empty_forward'),
                                  ),
                          ),
                        );
                      },
                    ),
                    SizedBox(width: 8.w),
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
                              return Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: 4.h,
                                  horizontal: 12.w,
                                ),
                                decoration: BoxDecoration(
                                  color: isDarkMode
                                      ? ColorResource.CANVAS_DARK_SECONDARY
                                      : ColorResource.CANVAS_LIGHT_SECONDARY,
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: Text(
                                  displayTitle,
                                  overflow: TextOverflow.clip,
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                  style: AppTextTheme.bodySmall(
                                    context,
                                  ).copyWith(fontWeight: FontWeight.bold),
                                ),
                              );
                            },
                          ),
                    ),
                    BlocSelector<AppWebviewCubit, AppWebviewState, bool>(
                      selector: (state) => state.loadingPercentage != 100,
                      builder: (context, isLoading) {
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
                            transitionBuilder: (child, animation) {
                              return ScaleTransition(
                                scale: animation,
                                child: FadeTransition(
                                  opacity: animation,
                                  child: child,
                                ),
                              );
                            },
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
                    IconButton(
                      onPressed: () async {
                        await _webViewController.clearHistory();
                        _webViewController.loadUrl(
                          urlRequest: URLRequest(url: WebUri(_baseUri)),
                        );
                      },
                      icon: FaIcon(FontAwesomeIcons.house, size: iconSize),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

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
