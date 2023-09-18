package com.example.voltron_screen_info

import android.content.Context
import android.content.res.Configuration
import android.content.res.Resources
import android.os.Build
import android.provider.Settings
import android.text.TextUtils
import android.util.DisplayMetrics
import android.util.Log
import android.view.WindowInsets
import android.view.WindowManager
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result


/** VoltronScreenInfoPlugin */
class VoltronScreenInfoPlugin : FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel

    private var applicationContext: Context? = null

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "voltron_screen_info")
        channel.setMethodCallHandler(this)
        applicationContext = flutterPluginBinding.applicationContext
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        if (call.method.equals("getScreenInfo")) {
            val context = applicationContext!!
            val screenInfo: MutableMap<String, Any> = HashMap()
            val windowDisplayMetrics = context.resources?.displayMetrics
            val screenDisplayMetrics = DisplayMetrics()
            screenDisplayMetrics.setTo(windowDisplayMetrics)
            val windowManager =
                context.getSystemService(Context.WINDOW_SERVICE) as WindowManager
            val defaultDisplay = windowManager.defaultDisplay
            defaultDisplay.getRealMetrics(screenDisplayMetrics)
            val density = screenDisplayMetrics.density
            val scaledDensity = screenDisplayMetrics.scaledDensity
            val densityDpi = screenDisplayMetrics.densityDpi
            val statusBarHeight = getStatusBarHeight(context) / density
            val navigationBarHeight = getNavigationBarHeight(context) / density
            val screenDisplayWidth = screenDisplayMetrics.widthPixels / density
            val screenDisplayHeight = screenDisplayMetrics.heightPixels / density
            val windowDisplayWidth =
                (windowDisplayMetrics?.widthPixels ?: screenDisplayMetrics.widthPixels) / density
            val windowDisplayHeight =
                (windowDisplayMetrics?.heightPixels ?: screenDisplayMetrics.heightPixels) / density
            val nightMode = getNightMode(context)

            screenInfo["screenWidth"] = screenDisplayWidth
            screenInfo["screenHeight"] = screenDisplayHeight
            screenInfo["windowWidth"] = windowDisplayWidth
            screenInfo["windowHeight"] = windowDisplayHeight
            screenInfo["scale"] = density
            screenInfo["fontScale"] = scaledDensity
            screenInfo["densityDpi"] = densityDpi
            screenInfo["statusBarHeight"] = statusBarHeight
            screenInfo["navigationBarHeight"] = navigationBarHeight
            screenInfo["nightMode"] = nightMode
            result.success(screenInfo)
        } else {
            result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    private fun getStatusBarHeight(context: Context): Int {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
            val windowManager = context.getSystemService(Context.WINDOW_SERVICE) as WindowManager
            val windowMetrics = windowManager.currentWindowMetrics
            val windowInsets = windowMetrics.windowInsets
            val insets = windowInsets.getInsetsIgnoringVisibility(WindowInsets.Type.statusBars())
            return insets.top
        } else {
            var statusBarHeight = 0
            try {
                val resId = context.resources.getIdentifier("status_bar_height", "dimen", "android")
                if (resId > 0) {
                    statusBarHeight = context.resources.getDimensionPixelSize(resId)
                }
            } catch (e: Exception) {
                Log.d("DimensionsUtil", "getStatusBarHeight: " + e.message)
            }
            if (statusBarHeight == 0) {
                try {
                    val resourceId = context.resources.getIdentifier(
                        "status_bar_height",
                        "dimen",
                        "com.android.systemui"
                    )
                    if (resourceId > 0) {
                        statusBarHeight = context.resources.getDimensionPixelSize(resourceId)
                    }
                } catch (e: Exception) {
                    Log.d("DimensionsUtil", "getStatusBarHeight: " + e.message)
                }
            }
            return statusBarHeight
        }
    }

    /**
     * 获取虚拟按键的高度 1. 全面屏下 1.1 开启全面屏开关-返回0 1.2 关闭全面屏开关-执行非全面屏下处理方式 2. 非全面屏下 2.1 没有虚拟键-返回0 2.1
     * 虚拟键隐藏-返回0 2.2 虚拟键存在且未隐藏-返回虚拟键实际高度
     */
    private fun getNavigationBarHeight(context: Context): Int {
        if (!checkNavigationBarShow(context)) {
            return 0
        }
        val navBarHeightIdentifier: String = if (context.resources.configuration.orientation
            != Configuration.ORIENTATION_LANDSCAPE
        ) "navigation_bar_height" else "navigation_bar_height_landscape"
        var result = 0
        try {
            val resourceId =
                context.resources.getIdentifier(navBarHeightIdentifier, "dimen", "android")
            result = context.resources.getDimensionPixelSize(resourceId)
        } catch (e: Resources.NotFoundException) {
            Log.d("DimensionsUtil", "getNavigationBarHeight: " + e.message)
        }
        return result
    }

    private fun getNavigationBarIsMinKeyName(): String {
        val brand = Build.BRAND
        if (TextUtils.isEmpty(brand)) {
            return "navigationbar_is_min"
        }
        return if (brand.equals("HUAWEI", ignoreCase = true)) {
            "navigationbar_is_min"
        } else if (brand.equals("XIAOMI", ignoreCase = true)) {
            "force_fsg_nav_bar"
        } else if (brand.equals("VIVO", ignoreCase = true)) {
            "navigation_gesture_on"
        } else if (brand.equals("OPPO", ignoreCase = true)) {
            "navigation_gesture_on"
        } else {
            "navigationbar_is_min"
        }
    }

    private fun checkNavigationBarShow(context: Context): Boolean {
        var checkResult = false
        val rs = context.resources
        val id = rs.getIdentifier(
            "config_showNavigationBar",
            "bool",
            "android"
        )
        if (id > 0) {
            checkResult = rs.getBoolean(id)
        }
        try {
            val systemPropertiesClass = Class.forName("android.os.SystemProperties")
            val m = systemPropertiesClass.getMethod("get", String::class.java)
            val navBarOverride = m.invoke(systemPropertiesClass, "qemu.hw.mainkeys") as String
            //判断是否隐藏了底部虚拟导航
            val navigationBarIsMin = Settings.Global.getInt(
                context.contentResolver,
                getNavigationBarIsMinKeyName(), 0
            )
            if ("1" == navBarOverride || 1 == navigationBarIsMin) {
                checkResult = false
            } else if ("0" == navBarOverride) {
                checkResult = true
            }
        } catch (e: Exception) {
            e.printStackTrace()
        }
        return checkResult
    }

    /**
     * 获取是否夜间模式
     */
    private fun getNightMode(context: Context): Boolean {
        return when (context.resources.configuration.uiMode and Configuration.UI_MODE_NIGHT_MASK) {
            Configuration.UI_MODE_NIGHT_UNDEFINED ->                 // We don't know what mode we're in, assume notnight
                false
            Configuration.UI_MODE_NIGHT_NO ->                 // Night mode is not active, we're in day time
                false
            Configuration.UI_MODE_NIGHT_YES ->                 // Night mode is active, we're at night!
                true
            else -> false
        }
    }
}
