import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AnimatedImage extends StatefulWidget {
  @override
  _AnimatedImageState createState() => _AnimatedImageState();
}

class _AnimatedImageState extends State<AnimatedImage> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
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
        print("Imagen presionada");
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
