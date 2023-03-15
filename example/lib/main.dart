import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_ads_deferred_deep_link/google_ads_deferred_deep_link.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _deepLink = 'Unknown';
  final _googleAdsDeferredDeepLinkPlugin = GoogleAdsDeferredDeepLink();

  @override
  void initState() {
    super.initState();
    _fetchDeferredDeepLink();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> _fetchDeferredDeepLink() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      _googleAdsDeferredDeepLinkPlugin.deferredDeepLinkStream.listen((event) {
        if (mounted) {
          setState(() {
            _deepLink = event?.deepLink ?? 'Callback Error';
          });
        }
      });
      _googleAdsDeferredDeepLinkPlugin.startFetch();
    } on PlatformException {
      if (mounted) {
        setState(() {
          _deepLink = 'Start Error';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Fetched deep link: $_deepLink\n'),
        ),
      ),
    );
  }
}
