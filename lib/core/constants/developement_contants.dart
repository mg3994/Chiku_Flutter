import 'dart:ui';

import 'package:flex_color_scheme/src/flex_scheme.dart';
import 'package:flutter/src/material/app.dart';
import 'package:injectable/injectable.dart';

import '../di/di_repository.dart';

@injectable
class DevelopementConstants implements ConstantsTemplate {
  @override
  int getIncrement() => 2;

  @override
  FlexScheme defaultFlexScheme() => FlexScheme.blueM3;

  @override
  Locale defaultLocale() => const Locale('ar', 'SA');

  @override
  ThemeMode defaultThemeMode() => ThemeMode.system;
}
