import 'android_screen_info.dart';
import 'ios_screen_info.dart';
import 'voltron_screen_info_platform_interface.dart';

class VoltronScreenInfoPlugin {
  VoltronScreenInfoPlugin();

  AndroidScreenInfo? _cachedAndroidScreenInfo;

  static VoltronScreenInfoPlatform get _platform {
    return VoltronScreenInfoPlatform.instance;
  }

  Future<AndroidScreenInfo> get androidInfo async =>
      _cachedAndroidScreenInfo ??= AndroidScreenInfo.fromMap((await _platform.screenInfo()).data);

  IosScreenInfo? _cachedIosDeviceInfo;

  Future<IosScreenInfo> get iosInfo async =>
      _cachedIosDeviceInfo ??= IosScreenInfo.fromMap((await _platform.screenInfo()).data);
}
