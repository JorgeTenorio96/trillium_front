import 'package:flutter_trillium/config/locator.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../data/services/localstorage_service.dart';

final getIt = GetIt.instance;

@InjectableInit()
void configureDependencies() => getIt.init();

void setupAsyncDependencies() {
  //var localStorageService = await LocalStorageService.getInstance();
  //getIt.registerSingleton(localStorageService);
  getIt.registerSingletonAsync<LocalStorageService>(
      () => LocalStorageService.getInstance());
}
