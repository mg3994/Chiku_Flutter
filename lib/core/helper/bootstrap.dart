import 'dart:io';

Future<void> bootstrap() async {
  if (Platform.isMacOS || Platform.isLinux || Platform.isWindows) {
    // await DesktopWindow.setMinWindowSize($styles.sizes.minAppSize);
  }

  if (Platform.isAndroid || Platform.isIOS || Platform.isFuchsia) {
    // await FlutterDisplayMode.setHighRefreshRate();
  }
}
