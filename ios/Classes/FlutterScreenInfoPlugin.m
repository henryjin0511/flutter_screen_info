#import "FlutterScreenInfoPlugin.h"
#if __has_include(<flutter_screen_info/flutter_screen_info-Swift.h>)
#import <flutter_screen_info/flutter_screen_info-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_screen_info-Swift.h"
#endif

@implementation FlutterScreenInfoPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterScreenInfoPlugin registerWithRegistrar:registrar];
}
@end
