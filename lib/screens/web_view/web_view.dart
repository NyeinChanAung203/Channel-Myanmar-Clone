import 'package:cm_movie/themes/styles.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewStack extends StatefulWidget {
  const WebViewStack({
    super.key,
    required this.controller,
  });

  final WebViewController controller;

  @override
  State<WebViewStack> createState() => _WebViewStackState();
}

class _WebViewStackState extends State<WebViewStack> {
  late final WebViewController controller;
  var loadingPercentage = 0;

  @override
  void initState() {
    super.initState();

    widget.controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(onPageStarted: (url) {
          setState(() {
            loadingPercentage = 0;
          });
        }, onProgress: (progress) {
          setState(() {
            loadingPercentage = progress;
          });
        }, onPageFinished: (url) {
          setState(() {
            loadingPercentage = 100;
          });
        }, onNavigationRequest: (request) {
          final host = Uri.parse(request.url).host;
          if (host.contains('youtube.com')) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Blocking navigation to $host')));
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        }),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WebViewWidget(
          controller: widget.controller,
        ),
        if (loadingPercentage < 100)
          LinearProgressIndicator(
            value: loadingPercentage / 100.0,
            color: kYellow,
          ),
      ],
    );
  }
}
