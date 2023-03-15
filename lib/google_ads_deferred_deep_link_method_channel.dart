import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'google_ads_deferred_deep_link.dart';
import 'google_ads_deferred_deep_link_platform_interface.dart';

@visibleForTesting
const String deferredDeepLinkUpdate = 'DeferredDeepLinkListener#onDeferredDeepLinkUpdated(String)';

/// An implementation of [GoogleAdsDeferredDeepLinkPlatform] that uses method channels.
class MethodChannelGoogleAdsDeferredDeepLink extends GoogleAdsDeferredDeepLinkPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('com.github/google_ads_deferred_deep_link');

  final StreamController<GoogleAdsDeferredDeepLinkResult?> _streamController =
      StreamController<GoogleAdsDeferredDeepLinkResult?>.broadcast();

  MethodChannelGoogleAdsDeferredDeepLink() {
    methodChannel.setMethodCallHandler(callHandler);
  }

  Future<void> callHandler(MethodCall call) async {
    switch (call.method) {
      case deferredDeepLinkUpdate:
        _streamController.add(
            GoogleAdsDeferredDeepLinkResult.fromMap((call.arguments as Map<dynamic, dynamic>).cast<String, dynamic>()));
        break;
    }
  }

  @override
  Stream<GoogleAdsDeferredDeepLinkResult?> get deferredDeepLinkStream => _streamController.stream;

  @override
  Future<String?> startFetch() async {
    if (!_streamController.hasListener) {
      throw Exception(
          'Before calling startFetch(), you should listen to deferredDeepLinkStream to get the result deferred deep link');
    }
    final res = await methodChannel.invokeMethod<String>('startFetch');
    return res;
  }
}
