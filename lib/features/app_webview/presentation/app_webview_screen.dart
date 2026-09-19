import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import 'package:flutter_flavors_boilerplate/core/di/app_dependency_manager.dart';
import 'package:flutter_flavors_boilerplate/features/app_webview/cubit/app_webview_cubit.dart';
import 'package:flutter_flavors_boilerplate/features/app_webview/presentation/widgets/webview_app_bar.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  static const int _scrollThreshold = 15; // dead-zone in pixels
  int _accumulatedDelta = 0;
  Timer? _webviewPositionTimer;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _webviewPositionTimer?.cancel();
    _isAppbarExtended.dispose();
    _shouldExtendWebview.dispose();
    super.dispose();
  }

  void _changeWebviewPosition() {
    _webviewPositionTimer?.cancel();
    _webviewPositionTimer = Timer(const Duration(milliseconds: 450), () {
      _shouldExtendWebview.value = _isAppbarExtended.value;
    });
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
                    final delta = y - _previousY;
                    _previousY = y;

                    // Reset accumulator on direction change
                    if ((delta > 0 && _accumulatedDelta < 0) ||
                        (delta < 0 && _accumulatedDelta > 0)) {
                      _accumulatedDelta = 0;
                    }
                    _accumulatedDelta += delta;

                    if (_accumulatedDelta > _scrollThreshold) {
                      // Scrolling down past threshold → hide appbar
                      if (_isAppbarExtended.value) {
                        _isAppbarExtended.value = false;
                        _changeWebviewPosition();
                      }
                      _accumulatedDelta = 0;
                    } else if (_accumulatedDelta < -_scrollThreshold) {
                      // Scrolling up past threshold → show appbar
                      if (!_isAppbarExtended.value) {
                        _isAppbarExtended.value = true;
                        _changeWebviewPosition();
                      }
                      _accumulatedDelta = 0;
                    }
                  },
                ),
              );
            },
          ),

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
            child: WebviewAppBar(
              height: appBarHeight,
              animationDuration: _appbarAnimationDuration,
              iconSize: iconSize,
              webViewController: _webViewController,
              baseUri: _baseUri,
              isDarkMode: isDarkMode,
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
