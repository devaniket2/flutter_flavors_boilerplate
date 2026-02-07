import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flavors_boilerplate/app/app.dart';
import 'package:flutter_flavors_boilerplate/core/config/app_config.dart';
import 'package:flutter_flavors_boilerplate/core/di/app_dependency_manager.dart';
import 'package:flutter_flavors_boilerplate/core/services/lifecycle_stream_event_handler.dart';
import 'package:flutter_flavors_boilerplate/core/services/network_connectivity_service.dart';

void main() async {
  // call before running the app to setup crucial services
  await _initAppServices();
  // start the main app
  runApp(FlavorBoilerplateApp());
}

/// call before running the app
/// to setup crucial services
Future<void> _initAppServices() async {
  // call before runApp for dependencies
  WidgetsFlutterBinding.ensureInitialized();

  // initiallize QA environment for app
  await AppDependencyManager.setup(BuildType.production);

  // detect network state changes
  StreamSubscription<List<ConnectivityResult>> networkActivityObserver =
      NetworkConnectivityService.detectNetworkChanges();

  // handles networkActivityObserver based on app lifecycle to avoid memory leaks
  WidgetsBinding.instance.addObserver(
    LifeCycleStreamEventHandler(
      onKilled: () => networkActivityObserver.cancel(),
      onPause: () => networkActivityObserver.pause(),
      onResume: () => networkActivityObserver.resume(),
    ),
  );
}
