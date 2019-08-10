import 'package:get_it/get_it.dart';
import 'package:avengers/core/services/avenger_service.dart';
import 'package:avengers/core/viewmodels/home_model.dart';

GetIt locator = GetIt();

void setupLocator() {
  locator.registerLazySingleton(() => AvengerService());

   locator.registerFactory(() => HomeModel());
}
