import 'package:flutter/material.dart';
import 'package:flutter_flavors_boilerplate/app/common/themes/text_theme/app_text_theme.dart';
import 'package:flutter_flavors_boilerplate/app/resources/color_resource.dart';
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
  final String _baseUri = "https://www.google.com";

  late InAppWebViewController _webViewController;

  final AppWebviewStateController _stateController =
      AppDependencyManager.getController();

  int _lastScrolled_Y = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // web view specific app bar
      appBar: AppBar(
        title: Row(
          children: [
            Obx(
              () => _stateController.canGoBack.value
                  ? IconButton(
                      onPressed: () async {
                        // failsafe condition
                        if (await _webViewController.canGoBack()) {
                          _webViewController.goBack();
                        }
                      },
                      icon: Icon(Icons.arrow_back_ios_new_outlined),
                    )
                  : const SizedBox.shrink(),
            ),

            Obx(
              () => _stateController.canGoForward.value
                  ? IconButton(
                      onPressed: () async {
                        // failsafe condition
                        if (await _webViewController.canGoForward()) {
                          _webViewController.goForward();
                        }
                      },
                      icon: Icon(Icons.arrow_forward_ios_rounded),
                    )
                  : const SizedBox.shrink(),
            ),

            Obx(
              () => Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 4.h,
                    horizontal: 12.w,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xFFEBEBEB), // light theme
                    // Color(0xff333333) // for dark theme
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    _stateController.title.value,
                    overflow: TextOverflow.fade,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: AppTextTheme.titleSmall(context),
                  ),
                ),
              ),
            ),

            Obx(() {
              // Determine the state once for cleaner code
              final isLoading = _stateController.loadingPercentage.value != 100;

              return IconButton(
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
                    return ScaleTransition(scale: animation, child: child);
                  },
                  // The Key is what tells AnimatedSwitcher to start the animation
                  child: Icon(
                    isLoading
                        ? FontAwesomeIcons.xmark
                        : FontAwesomeIcons.arrowsRotate,
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
              icon: Icon(FontAwesomeIcons.house),
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(3.0),
          child: Obx(() {
            if (_stateController.loadingPercentage > 99) {
              return const SizedBox.shrink();
            }

            return LinearProgressIndicator(
              value: _stateController.loadingPercentage.value / 100,
              backgroundColor: Colors.grey.shade300,
              color: ColorResource.SECONDARY_COLOR,
            );
          }),
        ),
      ),
      body: InAppWebView(
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
          if (hitTestResult.type == InAppWebViewHitTestResultType.IMAGE_TYPE ||
              hitTestResult.type ==
                  InAppWebViewHitTestResultType.SRC_IMAGE_ANCHOR_TYPE) {
            String? imageUrl = hitTestResult.extra; // This is the image URL

            if (imageUrl != null) {
              _showDownloadDialog(context, imageUrl);
            }
          }
        },
        onScrollChanged: (_, x, y) {
          if (y > _lastScrolled_Y) {
            print("Scrolling Down");
          } else if (y < _lastScrolled_Y) {
            print("Scrolling Up");
          }
          _lastScrolled_Y = y;
        },
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
