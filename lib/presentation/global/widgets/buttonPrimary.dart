import 'package:flutter/material.dart';

class ButtonPrimaryCustom extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final double? width;

  const ButtonPrimaryCustom({
    Key? key,
    required this.text,
    required this.onPressed,
    Color? color,
    this.width,
  })  : color = color ?? const Color(0xFF22014D),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width ?? MediaQuery.of(context).size.width,
        height: 55,
        decoration: BoxDecoration(
          color: color, // Utiliza el color asignado
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
