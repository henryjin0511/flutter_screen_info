import 'package:flutter_test/flutter_test.dart';
import 'package:voltron_screen_info/base_screen_info.dart';
import 'package:voltron_screen_info/ios_screen_info.dart';
import 'package:voltron_screen_info/voltron_screen_info.dart';
import 'package:voltron_screen_info/voltron_screen_info_platform_interface.dart';
import 'package:voltron_screen_info/voltron_screen_info_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockVoltronScreenInfoPlatform with MockPlatformInterfaceMixin implements VoltronScreenInfoPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<BaseScreenInfo> screenInfo() => Future.value(
        BaseScreenInfo({
          "screenWidth": 390.0,
          "screenHeight": 844.0,
          "windowWidth": 390.0,
          "windowHeight": 844.0,
          "scale": 3.0,
          "fontScale": 1.0,
          "statusBarHeight": 47.0,
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
    var iosScreenInfo = await voltronScreenInfoPlugin.iosInfo;
    expect(iosScreenInfo.screenWidth, 390.0);
    expect(iosScreenInfo.screenHeight, 844.0);
    expect(iosScreenInfo.windowWidth, 390.0);
    expect(iosScreenInfo.windowHeight, 844.0);
    expect(iosScreenInfo.scale, 3.0);
    expect(iosScreenInfo.fontScale, 1.0);
    expect(iosScreenInfo.statusBarHeight, 47.0);
  });
}
