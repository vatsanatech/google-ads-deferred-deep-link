package com.github.google_ads_deferred_deep_link

import android.content.Context
import android.content.SharedPreferences
import android.text.TextUtils
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** GoogleAdsDeferredDeepLinkPlugin */
class GoogleAdsDeferredDeepLinkPlugin : FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel: MethodChannel
  private lateinit var context: Context
  private var listener: SharedPreferences.OnSharedPreferenceChangeListener? = null
  private val deferredDeepLinkUpdate = "DeferredDeepLinkListener#onDeferredDeepLinkUpdated(String)"

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(
      flutterPluginBinding.binaryMessenger,
      "com.github/google_ads_deferred_deep_link"
    )
    context = flutterPluginBinding.applicationContext
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "startFetch") {
      val sp = context.getSharedPreferences(
        "google.analytics.deferred.deeplink.prefs",
        Context.MODE_PRIVATE
      )
      val isEmpty = checkDeepLink(sp)
      if (isEmpty) {
        if (listener != null) {
          sp.unregisterOnSharedPreferenceChangeListener(listener);
        }
        listener =
          SharedPreferences.OnSharedPreferenceChangeListener { prefs: SharedPreferences, key: String ->
            if (key == "deeplink") {
              checkDeepLink(prefs)
            }
          }
        sp.registerOnSharedPreferenceChangeListener(listener);
      }
      result.success("Success")
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    if (listener != null) {
      val sp = binding.applicationContext.getSharedPreferences(
        "google.analytics.deferred.deeplink.prefs",
        Context.MODE_PRIVATE
      )
      sp.unregisterOnSharedPreferenceChangeListener(listener)
      listener = null
    }
    channel.setMethodCallHandler(null)
  }

  private fun checkDeepLink(@NonNull sp: SharedPreferences): Boolean {
    val markSP =
      context.getSharedPreferences("google_ads_deferred_deep_link.mark", Context.MODE_PRIVATE)
    val deepLink: String? = sp.getString("deeplink", null)
    val isEmpty = TextUtils.isEmpty(deepLink)
    if (!isEmpty) {
      val cTime = sp.getLong("timestamp", 0L)
      val markTime = markSP.getLong("timestamp", -1L)
      if (markTime != cTime) {
        markSP.edit().putLong("timestamp", cTime).apply()
        channel.invokeMethod(
          deferredDeepLinkUpdate,
          mapOf("deepLink" to deepLink, "timestamp" to cTime)
        )
      }
    }
    return isEmpty
  }
}
