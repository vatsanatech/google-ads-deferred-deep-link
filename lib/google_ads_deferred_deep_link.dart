import 'google_ads_deferred_deep_link_platform_interface.dart';

class GoogleAdsDeferredDeepLink {
  Stream<GoogleAdsDeferredDeepLinkResult?> get deferredDeepLinkStream =>
      GoogleAdsDeferredDeepLinkPlatform.instance.deferredDeepLinkStream;

  Future<String?> startFetch() {
    return GoogleAdsDeferredDeepLinkPlatform.instance.startFetch();
  }
}

class GoogleAdsDeferredDeepLinkResult {
  final String? deepLink;
  final int? timestamp;

  GoogleAdsDeferredDeepLinkResult({
    this.deepLink,
    this.timestamp,
  });

  factory GoogleAdsDeferredDeepLinkResult.fromMap(Map<String, dynamic> map) {
    return GoogleAdsDeferredDeepLinkResult(
      deepLink: map['deepLink'] as String?,
      timestamp: map['timestamp'] as int?,
    );
  }
}
