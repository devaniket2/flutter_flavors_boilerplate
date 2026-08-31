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
      child: AppWebviewView(),
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
  final _appbarAnimationDuration = const Duration(milliseconds: 280);
  bool get isDarkMode => Theme.of(context).brightness == Brightness.dark;
  final double iconSize = 14.sp;
  final double appBarHeight = 60.h;

  // var y state - web scroll direction detect
  int previousY = -1;
  final ValueNotifier<bool> _isAppbarVisible = ValueNotifier(true);
  late final ValueNotifier<double> _webpageTopPosition;

  @override
  void initState() {
    super.initState();
    _webpageTopPosition = ValueNotifier(appBarHeight);
  }

  @override
  void dispose() {
    super.dispose();
    _isAppbarVisible.dispose();
    _webpageTopPosition.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          // -------------------------------------------------------------
          // WEBVIEW LAYER (Now entirely static, won't rebuild on progress)
          // -------------------------------------------------------------
          AnimatedBuilder(
            animation: _webpageTopPosition,
            builder: (context, child) {
              print('object ${_webpageTopPosition.value}');
              return Transform.translate(
                offset: Offset(0, _webpageTopPosition.value),
                child: child!,
              );
            },
            child: InAppWebView(
              initialSettings: InAppWebViewSettings(
                algorithmicDarkeningAllowed: isDarkMode ? true : false,
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
                if (_isScrollingDown(y)) {
                  _isAppbarVisible.value = false;
                } else {
                  _isAppbarVisible.value = true;
                }
              },
            ),
          ),

          // ValueListenableBuilder(
          //   valueListenable: _webpageTopPosition,
          //   child: InAppWebView(
          //     initialSettings: InAppWebViewSettings(
          //       algorithmicDarkeningAllowed: isDarkMode ? true : false,
          //     ),
          //     initialUrlRequest: URLRequest(url: WebUri(_baseUri)),
          //     onWebViewCreated: (controller) {
          //       _webViewController = controller;
          //     },
          //     onProgressChanged: (controller, progress) {
          //       context.read<AppWebviewCubit>().updateLoadingPercentage(
          //         progress.toDouble(),
          //       );
          //     },
          //     onTitleChanged: (controller, title) {
          //       context.read<AppWebviewCubit>().updateTitle(title ?? '');
          //     },
          //     onLoadStop: (controller, url) async {
          //       bool canGoBack = await _webViewController.canGoBack();
          //       bool canGoForward = await _webViewController.canGoForward();

          //       if (context.mounted) {
          //         context.read<AppWebviewCubit>().updateCanGoBack(canGoBack);
          //         context.read<AppWebviewCubit>().updateCanGoFoward(
          //           canGoForward,
          //         );
          //       }
          //     },
          //     onLongPressHitTestResult: (controller, hitTestResult) async {
          //       if (hitTestResult.type ==
          //               InAppWebViewHitTestResultType.IMAGE_TYPE ||
          //           hitTestResult.type ==
          //               InAppWebViewHitTestResultType.SRC_IMAGE_ANCHOR_TYPE) {
          //         String? imageUrl = hitTestResult.extra;
          //         if (imageUrl != null) {
          //           _showDownloadDialog(context, imageUrl);
          //         }
          //       }
          //     },
          //     onScrollChanged: (_, x, y) {
          //       if (_isScrollingDown(y)) {
          //         _isAppbarVisible.value = false;
          //       } else {
          //         _isAppbarVisible.value = true;
          //       }
          //     },
          //   ),
          //   builder: (context, isExtended, child) {
          //     return AnimatedBuilder(
          //       animation: _webpageTopPosition,
          //       builder: (context, child) {
          //         print('object @isExtended');
          //         return child!;
          //       },
          //       child: child,
          //     );
          //   },
          // ),

          // -------------------------------------------------------------
          // TOP APP BAR LAYER
          // -------------------------------------------------------------
          ValueListenableBuilder(
            valueListenable: _isAppbarVisible,
            child: Container(
              height: 60.h,
              width: 1.sw,
              alignment: Alignment.center,
              decoration: BoxDecoration(color: Theme.of(context).canvasColor),
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
                                    if (await _webViewController.canGoBack()) {
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
                                        ? ColorResource.CANVAS_DARK_SECONDARY
                                        : ColorResource.CANVAS_LIGHT_SECONDARY,
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                  child: AnimatedSwitcher(
                                    duration: _appbarAnimationDuration,
                                    transitionBuilder: (child, animation) =>
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
                                      style: AppTextTheme.bodySmall(
                                        context,
                                      ).copyWith(fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                    ),

                    // 4. Selector for Refresh / Close Action Button
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
                            transitionBuilder: (child, animation) =>
                                ScaleTransition(scale: animation, child: child),
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
                      icon: FaIcon(FontAwesomeIcons.house, size: iconSize),
                    ),
                  ],
                ),
              ),
            ),
            builder: (context, isVisible, child) {
              return AnimatedSlide(
                offset: isVisible ? Offset.zero : Offset(0, -1),
                duration: _appbarAnimationDuration,
                child: child,
                onEnd: () {
                  if (isVisible) {
                    _webpageTopPosition.value = appBarHeight;
                    print('extend page');
                  }

                  if (!isVisible) {
                    _webpageTopPosition.value = 0;
                    print('shrink page');
                  }
                },
              );
            },
          ),
        ],
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

  // helper to hide appbar

  bool _isScrollingDown(int currentY) {
    // Check if the current scroll position is greater than the last recorded one
    bool isDown = currentY > previousY;

    // Update previousY to the current position for the next check
    previousY = currentY;

    return isDown;
  }

  bool _isScrollingUp(int currentY) {
    // Check if the current scroll position is greater than the last recorded one
    bool isDown = currentY < previousY;

    // Update previousY to the current position for the next check
    previousY = currentY;

    return isDown;
  }

  Future<void> _downloadImage(String url) async {
    print("Downloading: $url");
  }
}
