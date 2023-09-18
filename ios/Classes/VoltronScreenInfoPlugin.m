#import "VoltronScreenInfoPlugin.h"
#if __has_include(<voltron_screen_info/voltron_screen_info-Swift.h>)
#import <voltron_screen_info/voltron_screen_info-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "voltron_screen_info-Swift.h"
#endif

@implementation VoltronScreenInfoPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftVoltronScreenInfoPlugin registerWithRegistrar:registrar];
}
@end
