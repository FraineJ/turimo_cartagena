import 'package:flutter/material.dart';
import 'package:turismo_cartagena/presentation/modules/auth/login/login.dart';


class RequestLogin extends StatelessWidget {
  final String title;
  final String description;

  const RequestLogin({super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 32,),
          Text(title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 26,
              height: 1.0
            ),
          ),
          const SizedBox(height: 16,),
          Text(description,
            style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w300,
                fontSize: 16,
                height: 1.3
            ),
          ),
          const SizedBox(height: 16,),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Login())
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFFE3E80), // Color de fondo del botón
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // Bordes redondeados
              ),
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12), // Espaciado interno
            ),
            child: const Text(
              'Inicia sesión',
              style: TextStyle(
                fontSize: 16, // Tamaño de la fuente
                fontWeight: FontWeight.bold, // Estilo de la fuente
                color: Colors.white, // Color del texto
              ),
            ),
          ),
        ],
      ),
    );
  }
}
