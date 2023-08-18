import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_screen_info_platform_interface.dart';

/// An implementation of [FlutterScreenInfoPlatform] that uses method channels.
class MethodChannelFlutterScreenInfo extends FlutterScreenInfoPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_screen_info');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
