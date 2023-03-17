# google_ads_deferred_deep_link

[Google Ads Deferred Deep Link](https://support.google.com/google-ads/answer/12373942?hl=en#zippy=%2Csteps-to-activate-ddl-in-the-gaf-sdk) plugin for [Flutter](https://flutter.io)

## Prerequisite

1. Read the [origin docs](https://support.google.com/google-ads/answer/12373942?hl=en#zippy=%2Csteps-to-activate-ddl-in-the-gaf-sdk) of Google Ads Deferred Deep Link
1. If possible, contact your business partner of Advertisement from both your orgnization and Google Ads.

## Getting Started

In your flutter project add the dependency:

```yaml
dependencies:
  ...
  firebase_core:
  firebase_analytics:
  google_ads_deferred_deep_link:
```

For help getting started with Flutter development, view the
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Enable the feature in your app

Modify your application manifest by adding the following metadata tag to your application tag.

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.myawesome.app">

    <uses-permission android:name="android.permission.INTERNET" />

    <application
     android:name=".MainActivity">

     <!-- Value to be added to enable deferred deep links -->
     <meta-data android:name="google_analytics_deferred_deep_link_enabled" android:value="true"/>

       <activity
            android:name=".MainActivity" >
       </activity>

    </application>

</manifest>
```

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
