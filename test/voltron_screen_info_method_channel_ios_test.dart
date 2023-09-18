import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:voltron_screen_info/base_screen_info.dart';
import 'package:voltron_screen_info/voltron_screen_info_method_channel.dart';

void main() {
  MethodChannelVoltronScreenInfo platform = MethodChannelVoltronScreenInfo();
  const MethodChannel channel = MethodChannel('voltron_screen_info');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      switch (methodCall.method) {
        case 'getScreenInfo':
          return <String, dynamic>{
            "screenWidth": 390.0,
            "screenHeight": 844.0,
            "windowWidth": 390.0,
            "windowHeight": 844.0,
            "scale": 3.0,
            "fontScale": 1.0,
            "statusBarHeight": 47.0,
          };
        default:
          assert(false);
          return null;
      }
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getScreenInfo', () async {
    var baseScreenInfo = await platform.screenInfo();
    var screenInfo = baseScreenInfo.data;
    expect(screenInfo["screenWidth"], 390.0);
    expect(screenInfo["screenHeight"], 844.0);
    expect(screenInfo["windowWidth"], 390.0);
    expect(screenInfo["windowHeight"], 844.0);
    expect(screenInfo["scale"], 3.0);
    expect(screenInfo["fontScale"], 1.0);
    expect(screenInfo["statusBarHeight"], 47.0);
  });
}
