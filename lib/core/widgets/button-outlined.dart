import 'package:flutter/material.dart';

class RegistrationButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final double width;
  final Color color;

  const RegistrationButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.width,
    required this.color
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width, // Ocupa todo el ancho disponible
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side:  BorderSide(color: color , width: 2), // Bordes rojos
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), // Bordes con radio de 8
          ),
          padding: const EdgeInsets.symmetric(vertical: 12), // Ajuste vertical
        ),
        child: Text(
          text,
          style: TextStyle(
            color: color , // Texto en rojo
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
