// ambient variable to access the service locator
import 'package:get_it/get_it.dart';
import 'package:state_part_get_it/src/settings/settings_controller.dart';
import 'package:state_part_get_it/src/settings/settings_service.dart';

GetIt sl = GetIt.instance;

void setUp() {
  // In General register the dependent serivce
  // before the other entity using it.

  sl.registerSingleton<SettingsService>(SettingsService());

  

  sl.registerFactory<SettingsController>(() => SettingsController(sl < SettingsService>()));
}
