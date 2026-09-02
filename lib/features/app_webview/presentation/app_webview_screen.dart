import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import 'package:flutter_flavors_boilerplate/app/common/themes/text_theme/app_text_theme.dart';
import 'package:flutter_flavors_boilerplate/app/resources/color_resource.dart';
import 'package:flutter_flavors_boilerplate/app/resources/string_resource.dart';
import 'package:flutter_flavors_boilerplate/core/di/app_dependency_manager.dart';
import 'package:flutter_flavors_boilerplate/features/app_webview/cubit/app_webview.state.dart';
import 'package:flutter_flavors_boilerplate/features/app_webview/cubit/app_webview_cubit.dart';
import 'package:flutter_flavors_boilerplate/features/app_webview/presentation/widgets/webview_app_bar.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppWebviewScreen extends StatelessWidget {
  const AppWebviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery.fromView(
      view: View.of(context),
      child: BlocProvider(
        create: (_) => AppDependencyManager.dependency<AppWebviewCubit>(),
        child: const AppWebviewView(),
      ),
    );
  }
}

class AppWebviewView extends StatefulWidget {
  const AppWebviewView({super.key});

  @override
  State<AppWebviewView> createState() => _AppWebviewViewState();
}

class _AppWebviewViewState extends State<AppWebviewView> {
  final String _baseUri = "https://www.google.com/search?q=wuthering waves";
  // https://in.pinterest.com/lonestarconfidential69/

  late InAppWebViewController _webViewController;
  final _appbarAnimationDuration = const Duration(milliseconds: 250);
  bool get isDarkMode => Theme.of(context).brightness == Brightness.dark;
  final double iconSize = 14.sp;
  late final double appBarHeight = 80.h;

  final ValueNotifier<bool> _isAppbarExtended = ValueNotifier(true);
  final ValueNotifier<bool> _shouldExtendWebview = ValueNotifier(false);

  int _previousY = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _isAppbarExtended.dispose();
    _shouldExtendWebview.dispose();
  }

  void _changeWebviewPosition() async {
    await Future.delayed(450.milliseconds);

    if (_isAppbarExtended.value) {
      _shouldExtendWebview.value = true;
    } else {
      _shouldExtendWebview.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // WEBVIEW LAYER
          ValueListenableBuilder(
            valueListenable: _shouldExtendWebview,
            builder: (context, value, child) {
              return TweenAnimationBuilder<double>(
                tween: Tween<double>(
                  begin: View.of(context).padding.top,
                  end: value ? appBarHeight : 0,
                ),
                duration: _appbarAnimationDuration,
                curve: Curves.easeInOut,
                builder: (context, pixelOffset, child) {
                  return Transform.translate(
                    // Animates smoothly by exact pixel offset
                    offset: Offset(0, pixelOffset),
                    child: child,
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
                      context.read<AppWebviewCubit>().updateCanGoBack(
                        canGoBack,
                      );
                      context.read<AppWebviewCubit>().updateCanGoFoward(
                        canGoForward,
                      );
                    }
                  },
                  onLongPressHitTestResult: (controller, hitTestResult) async {
                    if (hitTestResult.type ==
                            InAppWebViewHitTestResultType.IMAGE_TYPE ||
                        hitTestResult.type ==
                            InAppWebViewHitTestResultType
                                .SRC_IMAGE_ANCHOR_TYPE) {
                      String? imageUrl = hitTestResult.extra;
                      if (imageUrl != null) {
                        _showDownloadDialog(context, imageUrl);
                      }
                    }
                  },
                  onScrollChanged: (_, x, y) {
                    if (_isScrollingDown(y)) {
                      _isAppbarExtended.value = false;
                      _changeWebviewPosition();
                    } else {
                      _isAppbarExtended.value = true;
                      _changeWebviewPosition();
                    }
                  },
                ),
              );
            },
          ),

          // appbar
          // ValueListenableBuilder(
          //   valueListenable: _isAppbarExtended,
          //   child: WebviewAppBar(height: appBarHeight),
          //   builder: (context, isExtended, child) {
          //     return AnimatedSlide(
          //       offset: isExtended ? Offset.zero : Offset(0, -1),
          //       duration: _appbarAnimationDuration,
          //       child: child!,
          //     );
          //   },
          // ),

          // -------------------------------------------------------------
          // TOP APP BAR LAYER
          // -------------------------------------------------------------
          ValueListenableBuilder(
            valueListenable: _isAppbarExtended,
            builder: (context, isExtended, child) {
              return AnimatedSlide(
                offset: isExtended ? Offset.zero : Offset(0, -1),
                duration: _appbarAnimationDuration,
                child: child!,
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
                  crossAxisAlignment: CrossAxisAlignment.end,
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

  bool _isScrollingDown(int currentY) {
    final isDown = currentY > _previousY;
    _previousY = currentY;
    return isDown;
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
