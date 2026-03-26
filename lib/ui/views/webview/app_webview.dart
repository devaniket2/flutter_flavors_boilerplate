import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_flavors_boilerplate/app/common/themes/text_theme/app_text_theme.dart';
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

class _AppWebviewState extends State<AppWebview> {
  final String _baseUri = "https://www.google.com/search?q=wuthering waves";

  late InAppWebViewController _webViewController;

  final AppWebviewStateController _stateController =
      AppDependencyManager.getController();

  final _appbarAnimationDuration = const Duration(milliseconds: 350);

  int _lastScrolled_Y = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // PreferredSize(
      //   preferredSize: const Size.fromHeight(3.0),
      //   child: Obx(() {
      //     if (_stateController.loadingPercentage > 99) {
      //       return const SizedBox.shrink();
      //     }

      //     return LinearProgressIndicator(
      //       value: _stateController.loadingPercentage.value / 100,
      //       backgroundColor: Colors.grey.shade300,
      //       color: ColorResource.SECONDARY_COLOR,
      //     );
      //   }),
      // ),
      // appBar: PreferredSize(
      //   preferredSize: Size.fromHeight(kToolbarHeight),
      //   child: ,
      // ),
      body: SafeArea(
        child: Column(
          children: [
            // appbar
            Obx(() {
              String title = _stateController.title.value.isEmpty
                  ? StringResource.APP_TITLE
                  : _stateController.title.value;
              // Determine the state once for cleaner code
              bool isLoading = _stateController.loadingPercentage.value != 100;

              return _stateController.isAppbarVisible.value
                  ? Column(
                      children: [
                        Row(
                          children: [
                            AnimatedSwitcher(
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
                                      icon: const Icon(
                                        Icons.arrow_back_ios_new_outlined,
                                      ),
                                    )
                                  : const SizedBox(
                                      key: ValueKey('empty'), // 👈 IMPORTANT
                                      width: 0,
                                    ),
                            ),

                            AnimatedSwitcher(
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
                                      icon: const Icon(
                                        Icons.arrow_forward_ios_rounded,
                                      ),
                                    )
                                  : const SizedBox(
                                      key: ValueKey('empty_forward'),
                                      width: 0,
                                    ),
                            ),

                            SizedBox(width: 8.w),

                            Expanded(
                              child: AnimatedSize(
                                duration: _appbarAnimationDuration,
                                child: Container(
                                  constraints: BoxConstraints(
                                    maxWidth: 0.6.sw,
                                    minWidth: 0.3.sw,
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    vertical: 4.h,
                                    horizontal: 12.w,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFEBEBEB), // light theme
                                    // Color(0xff333333) // for dark theme
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                  child: AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 350),
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
                                      overflow: TextOverflow.fade,
                                      maxLines: 1,
                                      textAlign: TextAlign.center,
                                      style: AppTextTheme.titleSmall(context),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            IconButton(
                              onPressed: () async {
                                if (isLoading) {
                                  _webViewController.stopLoading();
                                } else {
                                  _webViewController.reload();
                                }
                              },
                              icon: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 300),
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
                                  key: ValueKey<bool>(isLoading),
                                ),
                              ),
                            ),

                            IconButton(
                              onPressed: () async {
                                await _webViewController.clearHistory();
                                _webViewController.loadUrl(
                                  urlRequest: URLRequest(url: WebUri(_baseUri)),
                                );
                              },
                              icon: Icon(FontAwesomeIcons.house),
                            ),
                          ],
                        ),
                      ],
                    )
                  : const SizedBox.shrink();
            }),

            // expanded webview
            Expanded(
              child: InAppWebView(
                initialSettings: InAppWebViewSettings(forceDark: ForceDark.ON),
                initialUrlRequest: URLRequest(url: WebUri(_baseUri)),
                onWebViewCreated: (controller) {
                  _webViewController = controller;
                },
                onProgressChanged: (controller, progress) {
                  _stateController.updateLoadingPercentage(progress.toDouble());
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
                          InAppWebViewHitTestResultType.SRC_IMAGE_ANCHOR_TYPE) {
                    String? imageUrl =
                        hitTestResult.extra; // This is the image URL

                    if (imageUrl != null) {
                      _showDownloadDialog(context, imageUrl);
                    }
                  }
                },
                onScrollChanged: (_, x, y) {},
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
