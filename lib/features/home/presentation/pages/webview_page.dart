import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  final String url;
  const WebViewPage({
    super.key,
    required this.url,
  });

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  WebViewController webViewController = WebViewController();

  @override
  void initState() {
    webViewController.setJavaScriptMode(JavaScriptMode.unrestricted);
    webViewController.loadRequest(Uri.parse(widget.url));
    super.initState();
  }

  Future<bool> willPop() async {
    if (await webViewController.canGoBack()) {
      webViewController.goBack();
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: willPop,
      child: WebViewWidget(
        controller: webViewController,
      ),
    );
  }
}
