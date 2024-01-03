import 'dart:core';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BannerScreen extends StatefulWidget {
  final String url;

  const BannerScreen({super.key, required this.url});

  @override
  State<BannerScreen> createState() => _BannerScreenState();
}

class _BannerScreenState extends State<BannerScreen> {
  WebViewController? _webViewController;

  @override
  void dispose() {
    _webViewController?.clearCache();
    _webViewController = null;

    super.dispose();
  }

  @override
  void initState() {
    var url = widget.url;
    _webViewController = WebViewController()
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {},
      )
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
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
      ..loadRequest(Uri.parse(widget.url));

    super.initState();
  }

  Future<bool> _onBack() async {
    if (_webViewController == null) return false;

    if (await _webViewController!.canGoBack()) {
      // 웹뷰에서 뒤로 갈 수 있으면 뒤로 간다
      await _webViewController?.goBack();
      return Future.value(false); // 이벤트 소비
    }
    return Future.value(true); // 시스템 뒤로 가기 동작 수행
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
  Widget build(BuildContext context) {
    return SafeArea(
        bottom: false,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () async {
                if (await goBack() && context.mounted) {
                  Navigator.pop(context);
                }
              },
            ),
          ),
          body: PopScope(
              canPop: false,
              onPopInvoked: (bool didPop) async {
                if (didPop) {
                  return;
                }
                if (await goBack() && context.mounted) {
                  Navigator.pop(context);
                }
              },
              child: WebViewWidget(controller: _webViewController!)),
        ));
  }
}
