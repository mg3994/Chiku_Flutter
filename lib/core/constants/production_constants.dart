
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../di/di_repository.dart';

@injectable
class ProductionConstants implements ConstantsTemplate {
  @override
  int getIncrement() => 1;
   @override
  FlexScheme defaultFlexScheme() => FlexScheme.cyanM3;

  @override
  Locale defaultLocale() => const Locale('en', 'US');

  @override
  ThemeMode defaultThemeMode() => ThemeMode.system;
}