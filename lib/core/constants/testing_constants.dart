import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../di/di_repository.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';

@injectable
class TestingConstants
// extends Mock
    implements
        ConstantsTemplate {
  @override
  int getIncrement() {
    return 5;
  }

  @override
  FlexScheme defaultFlexScheme() => FlexScheme.blueM3;

  @override
  Locale defaultLocale() => const Locale('en', 'US');

  @override
  ThemeMode defaultThemeMode() => ThemeMode.system;
}
