import Flutter
import UIKit

public class SwiftVoltronScreenInfoPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "voltron_screen_info", binaryMessenger: registrar.messenger())
        let instance = SwiftVoltronScreenInfoPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if ("getPlatformVersion".isEqual(call.method)) {
            result("iOS " + UIDevice.current.systemVersion)
        } else if ("getScreenInfo".isEqual(call.method) ){
            var screenSize = CGSizeZero
            var windowSize = CGSizeZero
            var statusBarHeight: CGFloat = 0
            var screenScale: CGFloat = 0
            executeOnMainThread(block: {() in
                screenSize = UIScreen.main.bounds.size;
                windowSize = screenSize
                if let window = UIApplication.shared.keyWindow {
                    windowSize = window.bounds.size
                }
                statusBarHeight = UIApplication.shared.statusBarFrame.height
                if #available(iOS 13.0, *) {
                    let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
                    statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? statusBarHeight
                }
                screenScale = UIScreen.main.scale
            }, sync: true)
            let screenWidth = screenSize.width
            let screenHeight = screenSize.height
            let windowWidth = windowSize.width
            let windowHeight = windowSize.height
            let nightMode = getNightMode();
            // 备注，window和screen的区别在于有没有底bar虚拟导航栏，而iOS没有这个东西，所以window和screen是一样的
            result([
                "screenWidth": screenWidth,
                "screenHeight": screenHeight,
                "windowWidth": windowWidth,
                "windowHeight": windowHeight,
                "scale": screenScale,
                "fontScale": 1.0,
                "statusBarHeight": statusBarHeight,
                "nightMode": nightMode
            ] as [String : Any])
        } else {
            result(FlutterMethodNotImplemented);
        }
    }
    
    public func executeOnMainThread (block: @escaping () -> Void, sync: Bool) {
        // 判断当前线程是否是主线程
        if Thread.current.isMainThread {
            // UI 事件
            block()
            return
        } else if (sync){
            // 切换到 main 线程，处理
            DispatchQueue.main.sync {
                block()
                return
            }
        } else {
            DispatchQueue.main.async {
                block()
                return
            }
        }
    }
    
    public func getNightMode() -> Bool {
        var res = false
        if #available(iOS 13.0, *) {
            if (UITraitCollection.current.userInterfaceStyle == UIUserInterfaceStyle.dark) {
                res = true;
            }
        }
        return res
    }
}




