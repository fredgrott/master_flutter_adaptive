import 'package:flutter/material.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:gorouter_part/src/app_logging.dart';
import 'package:gorouter_part/src/my_app.dart';


import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

void main() async {
  // Here we set the URL strategy for our web app.
  // It is safe to call this function when running on mobile or desktop as well.
  setPathUrlStrategy();

  AppLogging();



  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  final settingsController = SettingsController(SettingsService());

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await settingsController.loadSettings();

  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.
  runApp(MyApp(settingsController: settingsController));
}
