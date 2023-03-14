import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_ads_deferred_deep_link/google_ads_deferred_deep_link_method_channel.dart';

void main() {
  MethodChannelGoogleAdsDeferredDeepLink platform = MethodChannelGoogleAdsDeferredDeepLink();
  const MethodChannel channel = MethodChannel('com.github/google_ads_deferred_deep_link');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return 'Success';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.startFetch(), 'Success');
  });
}
