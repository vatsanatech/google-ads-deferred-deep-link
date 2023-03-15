import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'google_ads_deferred_deep_link.dart';
import 'google_ads_deferred_deep_link_method_channel.dart';

abstract class GoogleAdsDeferredDeepLinkPlatform extends PlatformInterface {
  /// Constructs a GoogleAdsDeferredDeepLinkPlatform.
  GoogleAdsDeferredDeepLinkPlatform() : super(token: _token);

  static final Object _token = Object();

  static GoogleAdsDeferredDeepLinkPlatform _instance =
      MethodChannelGoogleAdsDeferredDeepLink();

  /// The default instance of [GoogleAdsDeferredDeepLinkPlatform] to use.
  ///
  /// Defaults to [MethodChannelGoogleAdsDeferredDeepLink].
  static GoogleAdsDeferredDeepLinkPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [GoogleAdsDeferredDeepLinkPlatform] when
  /// they register themselves.
  static set instance(GoogleAdsDeferredDeepLinkPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Stream<GoogleAdsDeferredDeepLinkResult?> get deferredDeepLinkStream {
    throw UnimplementedError(
        'deferredDeepLinkStream has not been implemented.');
  }

  Future<String?> startFetch() {
    throw UnimplementedError('startFetch() has not been implemented.');
  }
}
