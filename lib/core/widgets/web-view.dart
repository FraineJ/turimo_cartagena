import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebPageViewer extends StatefulWidget {
  final String url;
  final String title;

  const WebPageViewer({required this.url, required this.title, Key? key}) : super(key: key);

  @override
  State<WebPageViewer> createState() => _WebPageViewerState();
}

class _WebPageViewerState extends State<WebPageViewer> {
  late final WebViewController _webViewController;

  @override
  void initState() {
    super.initState();
    // Inicializa el controlador de WebView
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted) // Permitir JavaScript
      ..loadRequest(Uri.parse(widget.url)); // Cargar la URL inicial
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(widget.title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
            ),
        ),
        backgroundColor: Colors.green,
      ),
      body: WebViewWidget(
        controller: _webViewController, // Usa el controlador inicializado
      ),
    );
  }
}
