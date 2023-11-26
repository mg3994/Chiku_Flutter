import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class LocalizationAndTheme extends StatefulWidget {
  final Widget child;

  /// List of supported locales.
  /// {@macro flutter.widgets.widgetsApp.supportedLocales}
  final List<Locale> supportedLocales;

  /// Locale when the locale is not in the list
  final Locale? fallbackLocale;

  /// Overrides device locale.
  final Locale? startLocale;

  /// Trigger for using only language code for reading localization files.
  /// @Default value false
  /// Example:
  /// ```
  /// en.json //useOnlyLangCode: true
  /// en-US.json //useOnlyLangCode: false
  /// ```
  final bool useOnlyLangCode;

  /// If a localization key is not found in the locale file, try to use the fallbackLocale file.
  /// @Default value false
  /// Example:
  /// ```
  /// useFallbackTranslations: true
  /// ```
  final bool useFallbackTranslations;

  /// Path to your folder with localization files.
  /// Example:
  /// ```dart
  /// path: 'assets/translations',
  /// path: 'assets/translations/lang.csv',
  /// ```
  final String path;

  /// Class loader for localization files.
  /// You can use custom loaders from [Easy Localization Loader](https://github.com/aissat/easy_localization_loader) or create your own class.
  /// @Default value `const RootBundleAssetLoader()`
  // ignore: prefer_typing_uninitialized_variables
  final assetLoader;

  /// Save locale in device storage.
  /// @Default value true
  final bool saveLocale;

  /// Shows a custom error widget when an error is encountered instead of the default error widget.
  /// @Default value `errorWidget = ErrorWidget()`
  final Widget Function(FlutterError? message)? errorWidget;

  final ThemeData lightTheme;
  final ThemeData darkTheme;
  final ThemeMode initialThemeMode;
  LocalizationAndTheme({
    Key? key,
    required this.child,
    required this.supportedLocales,
    required this.path,
    this.fallbackLocale,
    this.startLocale,
    this.useOnlyLangCode = false,
    this.useFallbackTranslations = false,
    this.assetLoader = const RootBundleAssetLoader(),
    this.saveLocale = true,
    this.errorWidget,
    required this.lightTheme,
    required this.darkTheme,
    required this.initialThemeMode,
  })  : assert(supportedLocales.isNotEmpty),
        assert(path.isNotEmpty),
        super(key: key);

  @override
  State<LocalizationAndTheme> createState() => _LocalizationAndThemeState();
  static _LocalizationAndThemeProvider? of(BuildContext context) =>
      _LocalizationAndThemeProvider.of(context);

  /// ensureInitialized needs to be called in main
  /// so that savedLocale is loaded and used from the
  /// start.
  static Future<void> ensureInitialized() async =>
      await LocalizationAndThemeController.initEasyLocation();
}

class _LocalizationAndThemeState extends State<LocalizationAndTheme> {
  _LocalizationDelegate? delegate;
  LocalizationAndThemeController? localizationController;
  FlutterError? translationsLoadError;

  @override
  void initState() {
    localizationController = LocalizationAndThemeController(
      saveLocale: widget.saveLocale,
      fallbackLocale: widget.fallbackLocale,
      supportedLocales: widget.supportedLocales,
      startLocale: widget.startLocale,
      assetLoader: widget.assetLoader,
      useOnlyLangCode: widget.useOnlyLangCode,
      useFallbackTranslations: widget.useFallbackTranslations,
      path: widget.path,
      onLoadError: (FlutterError e) {
        setState(() {
          translationsLoadError = e;
        });
      },
    );

    // Initialize theme based on the initialThemeMode
    // You might need to add logic to persist and retrieve the theme mode
    // when the app restarts.
    _initializeTheme(widget.initialThemeMode);
    // causes localization to rebuild with new language
    localizationController!.addListener(() {
      if (mounted) setState(() {});
    });
    super.initState();
  }

  // Initialize the theme based on the provided initialThemeMode
  void _initializeTheme(ThemeMode initialThemeMode) {
    final themeMode = initialThemeMode;
    if (themeMode == ThemeMode.light) {
      // Set the light theme
      // You might need to handle the theme switching logic elsewhere based on user preferences
      // This is just an example of how to set the theme based on the provided initialThemeMode
      // You could use this information to set up a theme switching mechanism.
      // For example, if a user selects a dark theme, you would need to update the app's theme to the dark theme.
      // This logic should be handled according to your app's requirements.
      // For simplicity, this example directly sets the theme based on the initialThemeMode.
      // You might need to handle theme changes dynamically in your app.
      // .setAppTheme(context, widget.lightTheme);
    } else if (themeMode == ThemeMode.dark) {
      // Set the dark theme
      // MyApp.setAppTheme(context, widget.darkTheme);
    }
  }

  @override
  void dispose() {
    localizationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (translationsLoadError != null) {
      return widget.errorWidget != null
          ? widget.errorWidget!(translationsLoadError)
          : ErrorWidget(translationsLoadError!);
    }
    return _LocalizationAndThemeProvider(
      widget,
      localizationController!,
      delegate: _LocalizationDelegate(
        localizationController: localizationController,
        supportedLocales: widget.supportedLocales,
      ),
    );
  }
}

class _LocalizationAndThemeProvider extends InheritedWidget {
  final LocalizationAndTheme parent;
  final LocalizationAndThemeController _localeState;
  final Locale? currentLocale;
  final _LocalizationDelegate delegate;
  const _LocalizationAndThemeProvider(this.parent, this._localeState,
      {Key? key, required this.delegate})
      : currentLocale = _localeState.locale,
        super(key: key, child: parent.child);
  List<LocalizationsDelegate> get delegates => [
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ];
  List<Locale> get supportedLocales => parent.supportedLocales;

  /// Get current locale
  Locale get locale => _localeState.locale;

  /// Get fallback locale
  Locale? get fallbackLocale => parent.fallbackLocale;
  // Locale get startLocale => parent.startLocale;

  /// Change app locale
  Future<void> setLocale(Locale locale) async {
    // Check old locale
    if (locale != _localeState.locale) {
      assert(parent.supportedLocales.contains(locale));
      await _localeState.setLocale(locale);
    }
  }

  /// Clears a saved locale from device storage
  Future<void> deleteSaveLocale() async {
    await _localeState.deleteSaveLocale();
  }

  /// Getting device locale from platform
  Locale get deviceLocale => _localeState.deviceLocale;

  /// Reset locale to platform locale
  Future<void> resetLocale() => _localeState.resetLocale();
  @override
  bool updateShouldNotify(_LocalizationAndThemeProvider oldWidget) {
    // TODO: implement updateShouldNotify
    return oldWidget.currentLocale != locale ||
        oldWidget.themeScheme != themeScheme;
  }

  static _LocalizationAndThemeProvider? of(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<_LocalizationAndThemeProvider>();
}

class _LocalizationDelegate extends LocalizationsDelegate<Localization> {
  final List<Locale>? supportedLocales;
  final LocalizationAndThemeController? localizationController;

  ///  * use only the lang code to generate i18n file path like en.json or ar.json
  // final bool useOnlyLangCode;

  _LocalizationDelegate({this.localizationController, this.supportedLocales});

  @override
  bool isSupported(Locale locale) => supportedLocales!.contains(locale);

  @override
  Future<Localization> load(Locale value) async {
    // EasyLocalization.logger.debug('Load Localization Delegate'); //Commented by Manish
    if (localizationController!.translations == null) {
      await localizationController!.loadTranslations();
    }

    Localization.load(value,
        translations: localizationController!.translations,
        fallbackTranslations: localizationController!.fallbackTranslations);
    return Future.value(Localization.instance);
  }

  @override
  bool shouldReload(LocalizationsDelegate<Localization> old) => false;
}
