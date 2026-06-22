import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_flavors_boilerplate/app/common/themes/text_theme/app_text_theme.dart';
import 'package:flutter_flavors_boilerplate/app/resources/color_resource.dart';
import 'package:flutter_flavors_boilerplate/app/resources/string_resource.dart';
import 'package:flutter_flavors_boilerplate/core/di/app_dependency_manager.dart';
import 'package:flutter_flavors_boilerplate/ui/views/webview/app_webview_state.getx.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class AppWebview extends StatefulWidget {
  const AppWebview({super.key});

  @override
  State<AppWebview> createState() => _AppWebviewState();
}

class _AppWebviewState extends State<AppWebview>
    with SingleTickerProviderStateMixin {
  final String _baseUri = "https://www.google.com/search?q=wuthering waves";

  late InAppWebViewController _webViewController;

  final AppWebviewStateController _stateController =
      AppDependencyManager.getController();

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

    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            // webview
            Positioned.fill(
              child: AnimatedBuilder(
                animation: _appbarAnimation,
                builder: (_, child) => Transform.translate(
                  offset: Offset(0, _webpageAnimation.value),
                  child: child,
                ),
                child: InAppWebView(
                  initialSettings: InAppWebViewSettings(
                    forceDark: isDarkMode ? ForceDark.ON : ForceDark.OFF,
                  ),
                  initialUrlRequest: URLRequest(url: WebUri(_baseUri)),
                  onWebViewCreated: (controller) {
                    _webViewController = controller;
                  },
                  onProgressChanged: (controller, progress) {
                    _stateController.updateLoadingPercentage(
                      progress.toDouble(),
                    );
                  },
                  onTitleChanged: (controller, title) {
                    _stateController.updateTitle(title ?? '');
                  },
                  onLoadStop: (controller, url) async {
                    bool canGoBack = await _webViewController.canGoBack();
                    bool canGoForward = await _webViewController.canGoForward();
                    _stateController.updateCanGoBack(canGoBack);
                    _stateController.updateCanGoFoward(canGoForward);
                  },
                  onLongPressHitTestResult: (controller, hitTestResult) async {
                    // Check if the user long-pressed an image
                    if (hitTestResult.type ==
                            InAppWebViewHitTestResultType.IMAGE_TYPE ||
                        hitTestResult.type ==
                            InAppWebViewHitTestResultType
                                .SRC_IMAGE_ANCHOR_TYPE) {
                      String? imageUrl =
                          hitTestResult.extra; // This is the image URL

                      if (imageUrl != null) {
                        _showDownloadDialog(context, imageUrl);
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
                ),
              ),
            ),

            // topbar
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AnimatedBuilder(
                animation: _appbarAnimation,
                child: Container(
                  height: 60.h,
                  width: 1.sw,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Theme.of(context).canvasColor,
                  ),
                  child: Padding(
                    padding: EdgeInsetsGeometry.symmetric(vertical: 8.h),
                    child: Column(
                      children: [
                        //
                        Row(
                          children: [
                            Obx(
                              () => AnimatedSwitcher(
                                duration: _appbarAnimationDuration,
                                transitionBuilder: (child, animation) {
                                  return FadeTransition(
                                    opacity: animation,
                                    child: SizeTransition(
                                      sizeFactor: animation,
                                      axis: Axis
                                          .horizontal, // 👈 smooth width expand/shrink
                                      child: child,
                                    ),
                                  );
                                },
                                child: _stateController.canGoBack.value
                                    ? IconButton(
                                        key: const ValueKey(
                                          'back_button',
                                        ), // 👈 IMPORTANT
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
                                        key: ValueKey('empty'), // 👈 IMPORTANT
                                        width: 0,
                                      ),
                              ),
                            ),

                            Obx(
                              () => AnimatedSwitcher(
                                duration: _appbarAnimationDuration,
                                transitionBuilder: (child, animation) {
                                  return FadeTransition(
                                    opacity: animation,
                                    child: SizeTransition(
                                      sizeFactor: animation,
                                      axis: Axis
                                          .horizontal, // 👈 smooth width expand/shrink
                                      child: child,
                                    ),
                                  );
                                },
                                child: _stateController.canGoForward.value
                                    ? IconButton(
                                        key: const ValueKey(
                                          'forward_button',
                                        ), // 👈 important
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
                              ),
                            ),

                            SizedBox(width: 8.w),

                            Expanded(
                              child: Obx(() {
                                String title =
                                    _stateController.title.value.isEmpty
                                    ? StringResource.APP_TITLE
                                    : _stateController.title.value;

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
                                          : ColorResource
                                                .CANVAS_LIGHT_SECONDARY,
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                    child: AnimatedSwitcher(
                                      duration: _appbarAnimationDuration,
                                      transitionBuilder: (child, animation) {
                                        return FadeTransition(
                                          opacity: animation,
                                          child: child,
                                        );
                                      },
                                      child: Text(
                                        title,
                                        key: ValueKey(
                                          title,
                                        ), // IMPORTANT: lets Flutter detect change
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
                              }),
                            ),

                            Obx(() {
                              bool isLoading =
                                  _stateController.loadingPercentage.value !=
                                  100;

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
                                    // You can use ScaleTransition, RotationTransition, or just FadeTransition
                                    return ScaleTransition(
                                      scale: animation,
                                      child: child,
                                    );
                                  },
                                  // The Key is what tells AnimatedSwitcher to start the animation
                                  child: Icon(
                                    isLoading
                                        ? FontAwesomeIcons.xmark
                                        : FontAwesomeIcons.arrowsRotate,
                                    size: iconSize,
                                    key: ValueKey<bool>(isLoading),
                                  ),
                                ),
                              );
                            }),

                            IconButton(
                              onPressed: () async {
                                await _webViewController.clearHistory();
                                _webViewController.loadUrl(
                                  urlRequest: URLRequest(url: WebUri(_baseUri)),
                                );
                              },
                              icon: Icon(
                                FontAwesomeIcons.house,
                                size: iconSize,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, _appbarAnimation.value),
                    child: child,
                  );
                },
              ),
            ),
          ],
        ),
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
    // 1. Request Permissions (use permission_handler)
    // 2. Download bytes using Dio or http
    // 3. Save to Gallery using image_gallery_saver or gal
    print("Downloading: $url");
  }
}
