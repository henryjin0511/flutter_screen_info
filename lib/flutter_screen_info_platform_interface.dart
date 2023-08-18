import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_screen_info_method_channel.dart';

abstract class FlutterScreenInfoPlatform extends PlatformInterface {
  /// Constructs a FlutterScreenInfoPlatform.
  FlutterScreenInfoPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterScreenInfoPlatform _instance = MethodChannelFlutterScreenInfo();

  /// The default instance of [FlutterScreenInfoPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterScreenInfo].
  static FlutterScreenInfoPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterScreenInfoPlatform] when
  /// they register themselves.
  static set instance(FlutterScreenInfoPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
