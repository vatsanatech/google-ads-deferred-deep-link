# google_ads_deferred_deep_link

[Google Ads Deferred Deep Link](https://support.google.com/google-ads/answer/12373942?hl=en#zippy=%2Csteps-to-activate-ddl-in-the-gaf-sdk) plugin for [Flutter](https://flutter.io)

## Getting Started

In your flutter project add the dependency:

```yaml
dependencies:
  ...
  google_ads_deferred_deep_link:
```

For help getting started with Flutter development, view the
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Usage

import `google_ads_deferred_deep_link.dart`

```dart
import package:google_ads_deferred_deep_link/google_ads_deferred_deep_link.dart
```

```dart
GoogleAdsDeferredDeepLink _gaddl = GoogleAdsDeferredDeepLink();
_gaddl.deferredDeepLinkStream.listen((event) {
  print('Got google ads deferred deep link: ${event?.deepLink}');
}
_gaddl.startFetch();
```
