import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'base_screen_info.dart';
import 'voltron_screen_info_method_channel.dart';

abstract class VoltronScreenInfoPlatform extends PlatformInterface {
  /// Constructs a VoltronScreenInfoPlatform.
  VoltronScreenInfoPlatform() : super(token: _token);

  static final Object _token = Object();

  static VoltronScreenInfoPlatform _instance = MethodChannelVoltronScreenInfo();

  /// The default instance of [VoltronScreenInfoPlatform] to use.
  ///
  /// Defaults to [MethodChannelVoltronScreenInfo].
  static VoltronScreenInfoPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [VoltronScreenInfoPlatform] when
  /// they register themselves.
  static set instance(VoltronScreenInfoPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<BaseScreenInfo> screenInfo() {
    throw UnimplementedError('screenInfo() has not been implemented.');
  }
}
