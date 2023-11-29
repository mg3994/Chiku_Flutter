import 'package:chiku/core/helper/plugin/locale_theme/core_locale_theme_state.dart';
import 'package:chiku/main.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../../../di/di.dart';
import '../../../di/di_repository.dart';

class LocaleTheme extends StatefulWidget {
  final Widget child;
  final SharedPreferencesService sharedPreferencesService;
  final List<Locale?>? supportedLocales;
  final Locale? fallbackLocale;

  /// Overrides device locale.
  final Locale? startLocale;
  final bool useOnlyLangCode;

  /// If a localization key is not found in the locale file, try to use the fallbackLocale file.
  /// @Default value false
  /// Example:
  /// ```
  /// useFallbackTranslations: true
  /// ```
  final bool useFallbackTranslations;

  final FlexScheme? flexScheme; //TODO
  final ThemeMode? initialThemeMode; //TODO
  LocaleTheme({
    super.key,
    required this.child,
    this.supportedLocales,
    this.fallbackLocale = const Locale("en", 'US'),
    this.startLocale,
    this.useOnlyLangCode = true,
    this.useFallbackTranslations = true,
    this.flexScheme,
    this.initialThemeMode,
    required this.sharedPreferencesService,
  }) {
    //  fallbackLocale!.languageCode.isNotEmpty ?   : supportedLocales?.singleWhere((element) => element?.languageCode == "en"); //try using Default locale with Constant
  }

  @override
  State<LocaleTheme> createState() => LocaleThemeState();

  //  static Future<void> ensureInitialized() async =>
  //     await LocalizationAndThemeController.initEasyLocation(); //TODO
}

class LocaleThemeState extends State<LocaleTheme> {
  List<LocalizationsDelegate> get delegates => [
        // delegate, //TODO Add Class
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ];

  CoreLocaleThemeState state = CoreLocaleThemeState();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    state = CoreLocaleThemeState(
      // flexScheme: widget.flexScheme, //shared Pref
      themeMode: getIt<ConstantsTemplate>().defaultThemeMode(),

      ///widget.constantsTemplate.defaultThemeMode(),
      locale: getIt<ConstantsTemplate>().defaultLocale(),

      /// widget.constantsTemplate.defaultLocale(), //TODO key
      flexScheme: sharedPreferencesService.getFlexColorScheme() ??
          getIt<ConstantsTemplate>().defaultFlexScheme(),

      /// widget.constantsTemplate.defaultFlexScheme(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LocaleThemeProvider(
      stateWidget: this,
      state: state,
      child: widget.child,
    );
  }
}

class LocaleThemeProvider extends InheritedWidget {
  final CoreLocaleThemeState state;
  final LocaleThemeState stateWidget;
  const LocaleThemeProvider(
      {required this.state,
      required this.stateWidget,
      super.key,
      required super.child});

  static LocaleThemeState? of(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<LocaleThemeProvider>()
      ?.stateWidget;

  @override
  bool updateShouldNotify(covariant LocaleThemeProvider oldWidget) =>
      oldWidget.state != state;
}

///////////////////////////////////
///
///
// class IWProvider<T, U> extends InheritedWidget {
//   final T state;
//   final U stateWidget;

//   const IWProvider(
//       {required this.state,
//       required this.stateWidget,
//       super.key,
//       required super.child});

//   static T? of<T>(BuildContext context) {
//     return context
//         .dependOnInheritedWidgetOfExactType<IWProvider<T, dynamic>>()
//         ?.stateWidget;
//   }

//   @override
//   bool updateShouldNotify(covariant IWProvider<T, U> oldWidget) =>
//       oldWidget.state != state;
//   //  return oldWidget.state != state || oldWidget.stateWidget != stateWidget;
// }
