import 'package:chiku/core/helper/plugin/locale_theme/locale_theme.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'core/di/di.dart';
import 'core/di/di_repository.dart';
import 'core/helper/plugin/url_st/url_strategy_export.dart';

late SharedPreferencesService sharedPreferencesService;

void main() async {
  configureAppEnvDI(appEnvironment: Environment.prod);
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensure that Flutter bindings are initialized

  setPathUrlStrategy(); // Set URL strategy if needed
  sharedPreferencesService = getIt.get<SharedPreferencesService>();
  await sharedPreferencesService.initialize();
  // sf = await SharedPreferences.getInstance(); // Initialize SharedPreferences

  runApp(MyApp(
      // sharedPreferencesService: sharedPreferencesService,
      ));
}

class MyApp extends StatelessWidget {
  // final SharedPreferencesService sharedPreferencesService;
  const MyApp({
    super.key,
    // required this.sharedPreferencesService
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LocaleTheme(
      // fallbackLocale: ,
      sharedPreferencesService:
          sharedPreferencesService, //add loading logic o initialize this

      child: Builder(builder: (context) {
        final state = LocaleThemeProvider.of(context)?.state;
        debugPrint("${state?.flexScheme.name}here");
        debugPrint(state?.locale?.languageCode.toString());
        return MaterialApp(
          supportedLocales: [
            Locale('en', 'US'),
            Locale('ar', 'SA')
          ], //TODO from LocaleTheme impl
          locale: state?.locale,

          title: 'Flutter Demo',

          theme: FlexThemeData.light(
              scheme: state?.flexScheme, useMaterial3: true), //state.flexScheme
          // The Mandy red, dark theme.
          darkTheme: FlexThemeData.dark(
              scheme: state?.flexScheme, useMaterial3: true), //state.flexScheme
          // Use dark or light theme based on system setting.
          themeMode: state?.themeMode, //state.themeMode
          localizationsDelegates: LocaleThemeProvider.of(context)?.delegates,
          // theme: ThemeData(
          // FlexScheme.mandyRed
          //   // This is the theme of your application.
          //   //
          //   // TRY THIS: Try running your application with "flutter run". You'll see
          //   // the application has a purple toolbar. Then, without quitting the app,
          //   // try changing the seedColor in the colorScheme below to Colors.green
          //   // and then invoke "hot reload" (save your changes or press the "hot
          //   // reload" button in a Flutter-supported IDE, or press "r" if you used
          //   // the command line to start the app).
          //   //
          //   // Notice that the counter didn't reset back to zero; the application
          //   // state is not lost during the reload. To reset the state, use hot
          //   // restart instead.
          //   //
          //   // This works for code too, not just values: Most code changes can be
          //   // tested with just a hot reload.
          //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          //   useMaterial3: true,
          // ),
          home: const MyHomePage(title: 'Flutter Demo Home Page'),
        );
      }),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
