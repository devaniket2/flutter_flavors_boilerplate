import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_flavors_boilerplate/app/common/themes/text_theme/app_text_theme.dart';
import 'package:flutter_flavors_boilerplate/app/resources/color_resource.dart';
import 'package:flutter_flavors_boilerplate/features/app_webview/cubit/app_webview.state.dart';
import 'package:flutter_flavors_boilerplate/features/app_webview/cubit/app_webview_cubit.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WebviewAppBar extends StatelessWidget {
  final double height;
  final Duration animationDuration;
  final double iconSize;
  final InAppWebViewController webViewController;
  final String baseUri;
  final bool isDarkMode;

  const WebviewAppBar({
    super.key,
    required this.height,
    required this.animationDuration,
    required this.iconSize,
    required this.webViewController,
    required this.baseUri,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    final surfaceColor = isDarkMode
        ? ColorResource.CANVAS_DARK_PRIMARY
        : ColorResource.CANVAS_LIGHT_PRIMARY;
    final pillColor = isDarkMode
        ? ColorResource.CANVAS_DARK_SECONDARY
        : ColorResource.CANVAS_LIGHT_SECONDARY;
    final subtitleColor = isDarkMode
        ? ColorResource.TEXT_SUBTITLE_LIGHT
        : ColorResource.TEXT_SUBTITLE_DARK;

    return Container(
      height: height,
      width: 1.sw,
      decoration: BoxDecoration(
        color: surfaceColor,
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).dividerColor.withValues(alpha: 0.1),
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // ── Main toolbar row ──
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.w),
            child: Row(
              children: [
                // Back button
                _buildNavButton(
                  context: context,
                  selectorField: (state) => state.canGoBack,
                  activeKey: 'back',
                  emptyKey: 'empty_back',
                  icon: Icons.chevron_left_rounded,
                  onPressed: () async {
                    if (await webViewController.canGoBack()) {
                      webViewController.goBack();
                    }
                  },
                ),

                // Forward button
                _buildNavButton(
                  context: context,
                  selectorField: (state) => state.canGoForward,
                  activeKey: 'forward',
                  emptyKey: 'empty_forward',
                  icon: Icons.chevron_right_rounded,
                  onPressed: () async {
                    if (await webViewController.canGoForward()) {
                      webViewController.goForward();
                    }
                  },
                ),

                SizedBox(width: 4.w),

                // ── Title pill ──
                Expanded(
                  child: BlocSelector<AppWebviewCubit, AppWebviewState, String>(
                    selector: (state) => state.title,
                    builder: (context, title) {
                      final displayTitle = title.isEmpty ? 'New Tab' : title;
                      return Container(
                        height: 34.h,
                        padding: EdgeInsets.symmetric(horizontal: 14.w),
                        decoration: BoxDecoration(
                          color: pillColor,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.lock_outline_rounded,
                              size: 11.sp,
                              color: ColorResource.PRIMARY,
                            ),
                            SizedBox(width: 6.w),
                            Flexible(
                              child: Text(
                                displayTitle,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: AppTextTheme.bodySmall(context).copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: subtitleColor,
                                  letterSpacing: 0.2,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                SizedBox(width: 4.w),

                // Reload / Stop
                BlocSelector<AppWebviewCubit, AppWebviewState, bool>(
                  selector: (state) => state.loadingPercentage != 100,
                  builder: (context, isLoading) {
                    return _ToolbarIconButton(
                      onPressed: () async {
                        if (isLoading) {
                          webViewController.stopLoading();
                        } else {
                          webViewController.reload();
                        }
                      },
                      child: AnimatedSwitcher(
                        duration: animationDuration,
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

                // Home
                _ToolbarIconButton(
                  onPressed: () async {
                    await webViewController.clearHistory();
                    webViewController.loadUrl(
                      urlRequest: URLRequest(url: WebUri(baseUri)),
                    );
                  },
                  child: FaIcon(FontAwesomeIcons.house, size: iconSize),
                ),
              ],
            ),
          ),

          SizedBox(height: 4.h),

          // ── Loading progress bar ──
          BlocSelector<AppWebviewCubit, AppWebviewState, double>(
            selector: (state) => state.loadingPercentage,
            builder: (context, percentage) {
              final progress = percentage / 100.0;
              return AnimatedOpacity(
                opacity: progress >= 1.0 ? 0.0 : 1.0,
                duration: const Duration(milliseconds: 300),
                child: SizedBox(
                  height: 2.h,
                  child: LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.transparent,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      ColorResource.PRIMARY,
                    ),
                    minHeight: 2.h,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  /// Builds an animated back/forward navigation button that appears/disappears.
  Widget _buildNavButton({
    required BuildContext context,
    required bool Function(AppWebviewState) selectorField,
    required String activeKey,
    required String emptyKey,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return BlocSelector<AppWebviewCubit, AppWebviewState, bool>(
      selector: selectorField,
      builder: (context, isEnabled) {
        return AnimatedSwitcher(
          duration: animationDuration,
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: SizeTransition(
                sizeFactor: animation,
                axis: Axis.horizontal,
                child: child,
              ),
            );
          },
          child: isEnabled
              ? _ToolbarIconButton(
                  key: ValueKey(activeKey),
                  onPressed: onPressed,
                  child: Icon(icon, size: 22.sp),
                )
              : SizedBox.shrink(key: ValueKey(emptyKey)),
        );
      },
    );
  }
}

/// A compact, circular-splash icon button for the toolbar.
class _ToolbarIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;

  const _ToolbarIconButton({
    super.key,
    required this.onPressed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        customBorder: const CircleBorder(),
        child: Padding(padding: EdgeInsets.all(10.w), child: child),
      ),
    );
  }
}
