import 'package:equatable/equatable.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class CoreLocaleThemeState extends Equatable {
  // final SharedPreferences sharedPreferences;
  final Locale? locale;
  final FlexScheme flexScheme;
  final ThemeMode themeMode;
  const CoreLocaleThemeState({
    this.locale,
    this.flexScheme = FlexScheme.blueM3,
    this.themeMode = ThemeMode.system,
    // required this.sharedPreferences
  });

  CoreLocaleThemeState copyWith({
    Locale? locale,
    FlexScheme? flexScheme,
    ThemeMode? themeMode,
  }) {
    return CoreLocaleThemeState(
      locale: locale ?? this.locale,
      flexScheme: flexScheme ?? this.flexScheme,
      themeMode: themeMode ?? this.themeMode,
      // sharedPreferences: this.sharedPreferences,
    );
  }

  @override
  List<Object?> get props => [
        locale,
        flexScheme,
        themeMode,
      ];
}
