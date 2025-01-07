import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AnimatedImage extends StatefulWidget {
  @override
  _AnimatedImageState createState() => _AnimatedImageState();
}

class _AnimatedImageState extends State<AnimatedImage> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late WebViewController _webViewController;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    // Inicializa el controlador del WebView
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted) // Permitir JavaScript
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) {
            setState(() {
              isLoading = true; // La página comenzó a cargar
            });
          },
          onPageFinished: (_) {
            setState(() {
              isLoading = false; // La página terminó de cargar
            });
          },
        ),
      )
      ..loadRequest(Uri.parse('https://web-historia-cartagena.vercel.app/')); // Cargar URL

    // Controlador de animación
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
      lowerBound: 0.6, // Tamaño más pequeño
      upperBound: 0.8, // Tamaño más grande
    )..repeat(reverse: true); // Repetir hacia atrás para hacer el ciclo

    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut, // Aplica una curva a la animación
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Redirigir al WebView con la nueva URL al hacer tap
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Scaffold(

              body: Stack(
                children: [
                  WebViewWidget(
                    controller: _webViewController,
                  ),
                  Positioned(
                    top: 50,
                    left: 10,
                    child: GestureDetector(
                      onTap: () =>  Navigator.of(context).pop(),
                      child:  CircleAvatar(
                        backgroundColor: Colors.white.withOpacity(0.8),
                        child: const  Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ),
                  // Indicador de carga mientras se está cargando la página
                  if (isLoading)
                    const Center(
                      child: CircularProgressIndicator(),
                    ),
                ],
              ),
            ),
          ),
        );
      },
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: ClipOval(
          child: Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.red,
                width: 2,
              ),
            ),
            child: SvgPicture.asset(
              "assets/images/Flag_of_Cartagena.svg",
              width: 35.0,
              height: 35.0,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}
