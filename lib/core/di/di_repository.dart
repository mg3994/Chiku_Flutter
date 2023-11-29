// import 'package:crusher/core/di/injectable.dart';
// import 'package:crusher/core/repo/dev_counter_repository.dart';
// import 'package:injectable/injectable.dart';

// import '../repo/counter_repository.dart';
// import '../repo/mock_counter_repository.dart';

// // @injectable
// // @module
// // @Injectable(
// //   as: DevCounterRepository,
// // ) // env: [Env.dev])
// // @Injectable(
// //   as: CounterRepository,
// // ) // env: [Env.prod])
// // @Injectable(
// //   as: MockCounterRepository,
// // ) // env: [Env.test])
// @module
// abstract class ICounterRepository {
//   // @factoryMethod
//   // @Injectable(as: DevCounterRepository, env: [Env.dev])
//   // @Injectable(as: CounterRepository, env: [Env.prod])
//   // @Injectable(as: MockCounterRepository, env: [Env.test])

// //   int getIncrement();
// // }
//   int getIncrement();
//   @Named(Env.dev)
//   @injectable
//   ICounterRepository get devCounterRepository => DevCounterRepository();

//   @Named(Env.prod)
//   @injectable
//   ICounterRepository get counterRepository => CounterRepository();

//   @Named(Env.test)
//   @injectable
//   ICounterRepository get mockCounterRepository => MockCounterRepository();
// }
// // @injectable
// // // @factoryMethod
// // @Environment(Env.dev) // Replace with appropriate environment constants
// // ICounterRepository devCounterRepository() => DevCounterRepository();

// // @injectable
// // // @factoryMethod
// // @Environment(Env.prod) // Replace with appropriate environment constants
// // ICounterRepository counterRepository() => CounterRepository();

// // @injectable
// // // @factoryMethod
// // @Environment(Env.test) // Replace with appropriate environment constants
// // ICounterRepository mockCounterRepository() => MockCounterRepository();

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/developement_contants.dart';
import '../constants/production_constants.dart';
import '../constants/testing_constants.dart';

abstract class ConstantsTemplate {
  int getIncrement();
  FlexScheme defaultFlexScheme();
  Locale defaultLocale();
  ThemeMode defaultThemeMode();
}

// @module
// abstract class DiModule {
//   @injectable
//   CounterChangeNotifier counterChangeNotifier(ICounterRepository repository) =>
//       CounterChangeNotifier(repository);

//   // @injectable
//   // CounterRepository counterRepository() => CounterRepository();

//   // @injectable
//   // DevCounterRepository devCounterRepository() => DevCounterRepository();

//   // You can also add conditional registrations based on the environment
//   @Named(Env.dev)
//   @injectable
//   ICounterRepository devCounterRepository() => DevCounterRepository();

//   @Named(Env.prod)
//   @injectable
//   ICounterRepository counterRepository() => CounterRepository();
// }

@module
abstract class DiAppEnvModule {
  @dev
  @injectable
  ConstantsTemplate devEnvConstants() => DevelopementConstants();

  @prod
  @injectable
  ConstantsTemplate prodEnvConstants() => ProductionConstants();
  @test
  @injectable
  ConstantsTemplate testEnvConstants() => TestingConstants();
}

// @module
// abstract class RegisterModule {
//   @preResolve
//   Future<SharedPreferences> get sharedPreferences =>
//       SharedPreferences.getInstance();
// }
@lazySingleton
class SharedPreferencesService {
  late SharedPreferences sharedPreferences; //TODO make private

  // Initialize SharedPreferences asynchronously
  Future<void> initialize() async {
    debugPrint("Initializing SharedPreferences");
    sharedPreferences = await SharedPreferences.getInstance();
    // Perform any other initialization if needed
  }

  // Methods to interact with SharedPreferences
  String? getString(String key) {
    return sharedPreferences.getString(key);
  }

  Future<bool> setString(String key, String value) {
    return sharedPreferences.setString(key, value);
  }

  FlexScheme? getFlexColorScheme(String key) {
    //TODO Key
    final schemeName = sharedPreferences.getString(key);
    if (schemeName != null) {
      try {
        return FlexScheme.values.firstWhere(
          (scheme) => scheme.name == schemeName,
          // orElse: () => null,
        );
      } catch (_) {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<bool> setFlexColorScheme(String key, FlexScheme value) {
    return sharedPreferences.setString(key, value.name);
  }
}
