import 'package:flutter_test/flutter_test.dart';
import 'package:voltron_screen_info/android_screen_info.dart';
import 'package:voltron_screen_info/base_screen_info.dart';
import 'package:voltron_screen_info/voltron_screen_info.dart';
import 'package:voltron_screen_info/voltron_screen_info_platform_interface.dart';
import 'package:voltron_screen_info/voltron_screen_info_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockVoltronScreenInfoPlatform with MockPlatformInterfaceMixin implements VoltronScreenInfoPlatform {
  @override
  Future<BaseScreenInfo> screenInfo() => Future.value(
        BaseScreenInfo({
          "screenWidth": 411.0,
          "screenHeight": 844.0,
          "windowWidth": 411.0,
          "windowHeight": 844.0,
          "scale": 3.5,
          "fontScale": 3.5,
          "densityDpi": 560,
          "statusBarHeight": 27.0,
          "navigationBarHeight": 24.0,
        }),
      );
}

void main() {
  final VoltronScreenInfoPlatform initialPlatform = VoltronScreenInfoPlatform.instance;

  test('$MethodChannelVoltronScreenInfo is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelVoltronScreenInfo>());
  });

  test('getPlatformVersion', () async {
    VoltronScreenInfoPlugin voltronScreenInfoPlugin = VoltronScreenInfoPlugin();
    MockVoltronScreenInfoPlatform fakePlatform = MockVoltronScreenInfoPlatform();
    VoltronScreenInfoPlatform.instance = fakePlatform;
    var androidScreenInfo = await voltronScreenInfoPlugin.androidInfo;
    expect(androidScreenInfo.screenWidth, 411.0);
    expect(androidScreenInfo.screenHeight, 844.0);
    expect(androidScreenInfo.windowWidth, 411.0);
    expect(androidScreenInfo.windowHeight, 844.0);
    expect(androidScreenInfo.scale, 3.5);
    expect(androidScreenInfo.fontScale, 3.5);
    expect(androidScreenInfo.densityDpi, 560);
    expect(androidScreenInfo.statusBarHeight, 27.0);
    expect(androidScreenInfo.navigationBarHeight, 24.0);
  });
}
