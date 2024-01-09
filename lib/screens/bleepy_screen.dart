import 'dart:convert';
import 'dart:core';
import 'package:bleepy_flutter_example/screens/banner_screen.dart';
import 'package:bleepy_flutter_example/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

// CustomScheme 데이터 모델 (예시)
class CustomScheme {
  final String url;

  CustomScheme({required this.url});
}

class BleepyLauncherScreen extends StatefulWidget {
  final String launcherUrl;

  const BleepyLauncherScreen({super.key, required this.launcherUrl});

  @override
  State<BleepyLauncherScreen> createState() => _BleepyLauncherScreenState();
}

class _BleepyLauncherScreenState extends State<BleepyLauncherScreen> {
  WebViewController? _webViewController;
  final GlobalKey webViewKey = GlobalKey();

  @override
  void initState() {
    if (widget.launcherUrl.isEmpty) {
      Navigator.of(context).pop();
    }
    print('launcherUrl: ${widget.launcherUrl}');
    _webViewController = WebViewController()
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          final data = jsonDecode(message.message);
          final key = data['type'];

          switch (key) {
            case "closeLauncher":

              closeLauncher();
              break;

            case "moveNavigation":
              moveNavigation(message);
              break;

            default:
              break;
          }
        },
      )
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
            print('onProgress');
          },
          onPageStarted: (String url) {
            print('page started');
          },
          onPageFinished: (String url) {
            print('page finished');
          },
          onWebResourceError: (WebResourceError error) {
            print('onWebResourceError');
            print('error $error');
          },
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..enableZoom(false)
      ..loadRequest(Uri.parse(widget.launcherUrl));

    super.initState();
  }

  void closeLauncher() {
    Navigator.of(context).pop();
  }

  void moveNavigation(JavaScriptMessage message) {
    final data = jsonDecode(message.message);
    final String? url = data['url'];
    print('moveNavigation $url');

    getUrlInfo(url!);
  }

  String ensureTrailingSlash(String url) {
    if (!url.endsWith('/')) {
      late String targetUrl;
      print('ensureTrailingSlash');
      targetUrl = "$url/";
      print(targetUrl);
      return targetUrl;
    }
    return url;
  }

  void getUrlInfo(String url) {
    print('getUrlInfo $url');
    final RegExp pattern =
        RegExp(r'^bleepy:\/\/([a-z0-9-_.]*)', caseSensitive: false);
    final RegExpMatch? match = pattern.firstMatch(url);

    // 정규 표현식 매치 실패 시
    if (match == null) return;

    // 타입 추출
    final String? type = match.group(1);

    // URL 파라미터 파싱
    final Uri uriData = Uri.parse(url);
    final Map<String, String> params = uriData.queryParameters;
    if (params['url'] == null) return;

    // CustomScheme 객체 생성
    final CustomScheme data = CustomScheme(url: params['url']!);
    String dataUrl = data.url.trim();
    String targetUrl = ensureTrailingSlash(dataUrl);
    print('targetUrl $targetUrl');
    // 라우터 이동
    switch (type) {
      case "banner":
        Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) => BannerScreen(url: targetUrl),
              transitionDuration: const Duration(seconds: 0),
            )
        );
        break;
    }
  }

  Future<bool> goBack() async {
    if (await _webViewController!.canGoBack()) {
      await _webViewController!.goBack();
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        bottom: false,
        child: WebViewWidget( controller: _webViewController!));
  }
}
