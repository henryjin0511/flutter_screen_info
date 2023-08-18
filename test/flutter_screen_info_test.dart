import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_screen_info/flutter_screen_info.dart';
import 'package:flutter_screen_info/flutter_screen_info_platform_interface.dart';
import 'package:flutter_screen_info/flutter_screen_info_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterScreenInfoPlatform
    with MockPlatformInterfaceMixin
    implements FlutterScreenInfoPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterScreenInfoPlatform initialPlatform = FlutterScreenInfoPlatform.instance;

  test('$MethodChannelFlutterScreenInfo is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterScreenInfo>());
  });

  test('getPlatformVersion', () async {
    FlutterScreenInfo flutterScreenInfoPlugin = FlutterScreenInfo();
    MockFlutterScreenInfoPlatform fakePlatform = MockFlutterScreenInfoPlatform();
    FlutterScreenInfoPlatform.instance = fakePlatform;

    expect(await flutterScreenInfoPlugin.getPlatformVersion(), '42');
  });
}
