import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class WebScreen extends StatefulWidget {
  final String link;
  const WebScreen({Key? key, required this.link}) : super(key: key);

  @override
  State<WebScreen> createState() => _WebScreenState();
}

class _WebScreenState extends State<WebScreen> {
  WebViewController controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
      ),
    );
  @override
  void initState() {
    super.initState();
    controller.loadRequest(Uri.parse(widget.link));
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body:WebViewWidget(controller: controller,)
    ));
  }
}
