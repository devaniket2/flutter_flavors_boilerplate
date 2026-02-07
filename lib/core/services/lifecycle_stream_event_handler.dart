import 'package:flutter/material.dart';

class LifeCycleStreamEventHandler extends WidgetsBindingObserver {
  LifeCycleStreamEventHandler({
    this.onKilled,
    this.onResume,
    this.onInactive,
    this.onHidden,
    this.onPause,
  });

  final VoidCallback? onKilled;
  final VoidCallback? onResume;
  final VoidCallback? onInactive;
  final VoidCallback? onHidden;
  final VoidCallback? onPause;

  //  @override
  //  Future<bool> didPopRoute(){}

  //  @override
  //  void didHaveMemoryPressure(){}

  //  @override
  //  void didChangeLocale(Locale locale){}

  //  @override
  //  void didChangeTextScaleFactor(){}

  //  @override
  //  void didChangeMetrics(){}

  //  @override
  //  Future<bool> didPushRoute(String route){}

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.detached:
        onKilled?.call();

      case AppLifecycleState.resumed:
        onResume?.call();

      case AppLifecycleState.inactive:
        onInactive?.call();

      case AppLifecycleState.hidden:
        onHidden?.call();

      case AppLifecycleState.paused:
        onPause?.call();
    }
  }
}
