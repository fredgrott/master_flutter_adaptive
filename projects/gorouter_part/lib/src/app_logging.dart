// Copyright 2023 Fredrick Allan Grott. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

// ignore_for_file: unused_local_variable

import 'dart:developer';

import 'package:logging/logging.dart';
import 'package:logging_appenders/logging_appenders.dart';

/// The app Global logger.
final appLogger = Logger("LoggingDemo");

/// AppLogging class initializes the logging set up at object creation.
/// To call it is just AppLogging() within the main function block.
///
/// Note, this an obseverable log that operates in all modes including
/// release which means we do not use print but instead use log to output.
///
/// @author Fredrick Allan Grott.
class AppLogging {
  factory AppLogging() {
    return _appLogging;
  }

  AppLogging._internal() {
    _init();
  }

  static final AppLogging _appLogging = AppLogging._internal();

  void _init() {
    // disable hierarchical logger
    hierarchicalLoggingEnabled = false;

    Logger.root.level = Level.ALL;

    // stack traces are expensive so we turn this on for
    // severe and above
    recordStackTraceAtLevel = Level.SEVERE;

    // just so during a log level change that we know about it.
    // log is used instead of print as this is for observable
    // logging even in release mode
    Logger.root.onLevelChanged.listen((event) {
      log('${event?.name} changed');
    });

    // now to get the log output
    Logger.root.onRecord.listen((record) {
      if (record.error != null && record.stackTrace != null) {
        log(
          '${record.level.name}: ${record.loggerName}: ${record.time}: ${record.message}: ${record.error}: ${record.stackTrace}',
        );
        log(
          'level: ${record.level.name} loggerName: ${record.loggerName} time: ${record.time} message: ${record.message} error: ${record.error} exception: ${record.stackTrace}',
        );
      } else if (record.error != null) {
        log(
          'level: ${record.level.name} loggerName: ${record.loggerName} time: ${record.time} message: ${record.message} error: ${record.error}',
        );
      } else {
        log(
          'level: ${record.level.name} loggerName: ${record.loggerName} time: ${record.time} message: ${record.message}',
        );
      }
    });

    // Appenders set up for color logs
    PrintAppender(formatter: const ColorFormatter()).attachToLogger(Logger.root);

    // Any appendeing logs to 3rd party observable logging services
    // would be here using the logging appenders other appenders

  }
}
