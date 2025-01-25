import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionDialog extends StatelessWidget {
  final VoidCallback onAccept;

  PermissionDialog({required this.onAccept});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Aviso de Ubicación en Segundo Plano'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Para ofrecer una experiencia personalizada y mejorar el servicio, necesitamos acceder a tu ubicación en segundo plano.'),
          SizedBox(height: 16),
          Text('Este permiso permitirá que la aplicación rastree tu ubicación incluso cuando la aplicación esté en segundo plano, lo cual es necesario para algunas funciones específicas.'),
          SizedBox(height: 16),
          Text('Por favor, revisa y acepta la solicitud de permisos en el siguiente paso.'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Cierra el diálogo si el usuario no acepta
          },
          child: Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            onAccept(); // Llama a la función para solicitar el permiso
          },
          child: Text('Aceptar'),
        ),
      ],
    );
  }
}
