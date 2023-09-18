import 'base_screen_info.dart';

class AndroidScreenInfo extends BaseScreenInfo {
  AndroidScreenInfo._({
    required Map<String, dynamic> data,
    required this.screenWidth,
    required this.screenHeight,
    required this.windowWidth,
    required this.windowHeight,
    required this.statusBarHeight,
    required this.navigationBarHeight,
    required this.scale,
    required this.fontScale,
    required this.densityDpi,
    required this.nightMode,
  }) : super(data);

  final double screenWidth;
  final double screenHeight;
  final double windowWidth;
  final double windowHeight;
  final double statusBarHeight;
  final double navigationBarHeight;
  final double scale;
  final double fontScale;
  final int densityDpi;
  final bool nightMode;

  static AndroidScreenInfo fromMap(Map<String, dynamic> map) {
    return AndroidScreenInfo._(
      data: map,
      screenWidth: map['screenWidth'],
      screenHeight: map['screenHeight'],
      windowWidth: map['windowWidth'],
      windowHeight: map['windowHeight'],
      statusBarHeight: map['statusBarHeight'],
      navigationBarHeight: map['navigationBarHeight'],
      scale: map['scale'],
      fontScale: map['fontScale'],
      densityDpi: map['densityDpi'],
      nightMode: map['nightMode'],
    );
  }
}
