import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:google_ads_deferred_deep_link/google_ads_deferred_deep_link.dart';
import 'package:google_ads_deferred_deep_link/google_ads_deferred_deep_link_platform_interface.dart';
import 'package:google_ads_deferred_deep_link/google_ads_deferred_deep_link_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockGoogleAdsDeferredDeepLinkPlatform
    with MockPlatformInterfaceMixin
    implements GoogleAdsDeferredDeepLinkPlatform {
  final StreamController<GoogleAdsDeferredDeepLinkResult> _streamController =
      StreamController<GoogleAdsDeferredDeepLinkResult>();

  @override
  Stream<GoogleAdsDeferredDeepLinkResult?> get deferredDeepLinkStream =>
      _streamController.stream;

  @override
  Future<String?> startFetch() => Future.value('Success');
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final GoogleAdsDeferredDeepLinkPlatform initialPlatform =
      GoogleAdsDeferredDeepLinkPlatform.instance;

  test('$MethodChannelGoogleAdsDeferredDeepLink is the default instance', () {
    expect(initialPlatform,
        isInstanceOf<MethodChannelGoogleAdsDeferredDeepLink>());
  });

  test('startFetch', () async {
    GoogleAdsDeferredDeepLink googleAdsDeferredDeepLinkPlugin =
        GoogleAdsDeferredDeepLink();
    MockGoogleAdsDeferredDeepLinkPlatform fakePlatform =
        MockGoogleAdsDeferredDeepLinkPlatform();
    GoogleAdsDeferredDeepLinkPlatform.instance = fakePlatform;

    googleAdsDeferredDeepLinkPlugin.deferredDeepLinkStream.listen((event) {});
    expect(await googleAdsDeferredDeepLinkPlugin.startFetch(), 'Success');
  });
}
