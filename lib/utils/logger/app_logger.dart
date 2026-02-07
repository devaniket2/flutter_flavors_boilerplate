// A custom file to provide more robust set of logging functions
// for customizing developer experience
// Annotates with optional tag and emojis specific to log type
// which can be filtered easily for relevant information
//
// written by: Aniket Nandi 🙋🏼‍♂️

// ⚠️ NOTE: These functions works with escape sequences for formatting
// any changes  may break functionalities.
// Please discuss with me before making any changes to all the functions of this file.
// VS code only

// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:developer' as developer;

DateFormat showTime = DateFormat('hh:mm:ss.SSS');

/// prints custom log message to the console
///
/// if you want use a tag then set `tag` to a `String` value.
/// if you need `timestamp` then set `timestamp` to `true`.
/// if you need `stackTrace` then set `stackTrace` to `true`.
/// prints decorated message with `Cyan` text
void logMessage(
  String msg, {
  String? tag,
  bool timestamp = false,
  bool stackTrace = false,
}) {
  // Prepare the tag for the log message.
  String _tag = tag == null ? '' : '$tag: ';

  // Include a timestamp if requested.
  String _timestamp =
      timestamp == false ? '' : '| ⏰ ${showTime.format(DateTime.now())}';

  // Construct the log message with tag and timestamp.
  developer.log('📍 \x1B[36m$_tag$msg $_timestamp\x1B[0m');

  // Print the stack trace if enabled.
  if (stackTrace) debugPrintStack(stackTrace: StackTrace.current, maxFrames: 5);
}

/// prints custom log message to the console
///
/// if you want use a tag then set `tag` to a `String` value.
/// if you need `timestamp` then set `timestamp` to `true`.
/// if you need `stackTrace` then set `stackTrace` to `true`.
/// prints decorated message with `Magenta` text
void logInfo(
  String msg, {
  String? tag,
  bool timestamp = false,
  bool stackTrace = false,
}) {
  String _tag = tag == null ? '' : '$tag: ';
  String _timestamp =
      timestamp == false ? '' : '| ⏰ ${showTime.format(DateTime.now())}';
  developer.log('💬 \x1B[35m$_tag$msg $_timestamp\x1B[0m');
  if (stackTrace) debugPrintStack(stackTrace: StackTrace.current, maxFrames: 5);
}

/// prints custom log message to the console
///
/// if you want use a tag then set `tag` to a `String` value.
/// if you need `timestamp` then set `timestamp` to `true`.
/// if you need `stackTrace` then set `stackTrace` to `true`.
/// prints decorated message with `Green` text
void logSuccess(
  String msg, {
  String? tag,
  bool timestamp = false,
  bool stackTrace = false,
}) {
  String _tag = tag == null ? '' : '$tag: ';
  String _timestamp =
      timestamp == false ? '' : '| ⏰ ${showTime.format(DateTime.now())}';
  developer.log('✅ \x1B[32m$_tag$msg $_timestamp\x1B[0m');
  if (stackTrace) debugPrintStack(stackTrace: StackTrace.current, maxFrames: 5);
}

/// prints custom log message to the console
///
/// if you want use a tag then set `tag` to a `String` value.
/// if you need `timestamp` then set `timestamp` to `true`.
/// if you need `stackTrace` then set `stackTrace` to `true`.
/// prints decorated message with `Yellow` text
void logWarning(
  String msg, {
  String? tag,
  bool timestamp = false,
  bool stackTrace = false,
}) {
  String _tag = tag == null ? '' : '$tag: ';
  String _timestamp =
      timestamp == false ? '' : '| ⏰ ${showTime.format(DateTime.now())}';
  developer.log('🚧 \x1B[33m$_tag$msg $_timestamp\x1B[0m');
  if (stackTrace) debugPrintStack(stackTrace: StackTrace.current, maxFrames: 5);
}

/// prints custom log message to the console
///
/// if you want use a tag then set `tag` to a `String` value.
/// if you need `timestamp` then set `timestamp` to `true`.
/// if you need `stackTrace` then set `stackTrace` to `true`.
/// prints decorated message with `Red` text
void logError(
  String msg, {
  String? tag,
  bool timestamp = false,
  bool stackTrace = false,
}) {
  String _tag = tag == null ? '' : '$tag: ';
  String _timestamp =
      timestamp == false ? '' : '| ⏰ ${showTime.format(DateTime.now())}';
  developer.log('⛔️ \x1B[31m$_tag$msg $_timestamp\x1B[0m');
  if (stackTrace) debugPrintStack(stackTrace: StackTrace.current, maxFrames: 5);
}
