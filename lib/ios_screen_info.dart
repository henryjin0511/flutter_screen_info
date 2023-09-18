import 'base_screen_info.dart';

class IosScreenInfo extends BaseScreenInfo {
  IosScreenInfo._({
    required Map<String, dynamic> data,
    required this.screenWidth,
    required this.screenHeight,
    required this.windowWidth,
    required this.windowHeight,
    required this.statusBarHeight,
    required this.scale,
    required this.fontScale,
    required this.nightMode,
  }) : super(data);

  final double screenWidth;
  final double screenHeight;
  final double windowWidth;
  final double windowHeight;
  final double statusBarHeight;
  final double scale;
  final double fontScale;
  final bool nightMode;

  static IosScreenInfo fromMap(Map<String, dynamic> map) {
    return IosScreenInfo._(
      data: map,
      screenWidth: map['screenWidth'],
      screenHeight: map['screenHeight'],
      windowWidth: map['windowWidth'],
      windowHeight: map['windowHeight'],
      statusBarHeight: map['statusBarHeight'],
      scale: map['scale'],
      fontScale: map['fontScale'],
      nightMode: map['nightMode'],
    );
  }
}
