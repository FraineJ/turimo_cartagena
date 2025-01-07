import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ChatAna extends StatefulWidget {
  const ChatAna({super.key});

  @override
  State<ChatAna> createState() => _ChatAnaState();
}

class _ChatAnaState extends State<ChatAna> {
  late final WebViewController _webViewController;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) {
            setState(() {
              _isLoading = true; // Página comenzó a cargarse
            });
          },
          onPageFinished: (_) {
            setState(() {
              _isLoading = false; // Página terminó de cargarse
            });
          },
        ),
      )
      ..loadRequest(Uri.parse('https://frontend-ana.vercel.app/'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:   Stack(
          children: [
              WebViewWidget(controller: _webViewController),
              if (_isLoading)
              const Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      )
    );
  }
}
