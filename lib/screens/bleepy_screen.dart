import 'dart:convert';
import 'dart:core';
import 'package:bleepy_flutter_example/screens/banner_screen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

// CustomScheme 데이터 모델 (예시)
class CustomScheme {
  final String url;

  CustomScheme({required this.url});
}

class BleepyLauncherScreen extends StatefulWidget {
  const BleepyLauncherScreen({super.key});

  @override
  State<BleepyLauncherScreen> createState() => _BleepyLauncherScreenState();
}

class _BleepyLauncherScreenState extends State<BleepyLauncherScreen> {
  WebViewController? _webViewController;

  @override
  void initState() {
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
            print('error $error');
          },
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..enableZoom(false)
      ..loadRequest(Uri.parse(
          'http://192.168.10.32:5174?userKey=khhong&secretKey=b0967f6194a42fdaa0644e3cc7f7b8d56887c73de574832c0e936974acde8d74&platform=flutter'));

    super.initState();
  }

  void closeLauncher() {
    Navigator.of(context).pop();
  }

  void moveNavigation(JavaScriptMessage message) {
    final data = jsonDecode(message.message);
    final String? url = data['url'];

    getUrlInfo(url!);
  }

  void getUrlInfo(String url) {
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

    // 라우터 이동
    switch (type) {
      case "banner":
        Navigator.pushNamed(context, '/banner', arguments: {'url': data.url});
        break;
    }
  }

  Future<bool> goBack() async{
    if(await _webViewController!.canGoBack()){
      await _webViewController!.goBack();
      return Future.value(false);
    }else{
      return Future.value(true);
    }
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
        bottom: false,
        child: PopScope(
            canPop: false,
            onPopInvoked: (bool didPop) async {
              if (didPop) {
                return;
              }
              if (await goBack() && context.mounted) {
                Navigator.pop(context);
              }
            },
            child: WebViewWidget(controller: _webViewController!)));
  }
}