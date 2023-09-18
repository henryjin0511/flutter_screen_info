import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'base_screen_info.dart';
import 'voltron_screen_info_platform_interface.dart';

/// An implementation of [VoltronScreenInfoPlatform] that uses method channels.
class MethodChannelVoltronScreenInfo extends VoltronScreenInfoPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('voltron_screen_info');

  @override
  Future<BaseScreenInfo> screenInfo() async {
    Map<String, dynamic> screenInfo = {};
    try {
      screenInfo = await methodChannel.invokeMapMethod<String, dynamic>('getScreenInfo') ?? {};
    } catch (err) {
      //
    }
    return BaseScreenInfo(screenInfo);
  }
}
