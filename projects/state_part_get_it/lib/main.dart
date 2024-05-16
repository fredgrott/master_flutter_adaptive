import 'package:flutter/material.dart';
import 'package:state_part_get_it/service_locator.dart';

import 'src/app.dart';
import 'src/settings/settings_controller.dart';



void main() async {

  setUp();



  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  //final settingsController = SettingsController(SettingsService());

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await sl<SettingsController>().loadSettings();

  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.
  runApp(MyApp());
}
