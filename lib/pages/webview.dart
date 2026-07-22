import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsWebView extends StatefulWidget {
  const NewsWebView({super.key, required this.url, required this.title});

  final String url;
  final String title;

  @override
  State<NewsWebView> createState() => _NewsWebViewState();
}

class _NewsWebViewState extends State<NewsWebView> {
  late final WebViewController controller;

  Future<void> _handleBackNavigation() async {
    if (await controller.canGoBack()) {
      await controller.goBack();
    } else {
      if (context.mounted) {
        Navigator.pop(context);
      }
    }
  }

  @override
  void initState() {
    super.initState();

    controller = WebViewController()..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;

        _handleBackNavigation();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF1E3A8A),
          title: Text(widget.title, style: TextStyle(color: Colors.white)),
          leading: IconButton(
            onPressed: () async {
              _handleBackNavigation();
            },
            icon: Icon(Icons.arrow_back),
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: WebViewWidget(controller: controller),
      ),
    );
  }
}
