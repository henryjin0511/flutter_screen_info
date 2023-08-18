
import 'flutter_screen_info_platform_interface.dart';

class FlutterScreenInfo {
  Future<String?> getPlatformVersion() {
    return FlutterScreenInfoPlatform.instance.getPlatformVersion();
  }
}
