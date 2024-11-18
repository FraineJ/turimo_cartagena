import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ListPhone extends StatelessWidget {
  const ListPhone({super.key});

  // Función para hacer una llamada
  void _makePhoneCall(String phoneNumber) async {
    final Uri url = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'No se pudo abrir el número $phoneNumber';
    }
  }

  @override
  Widget build(BuildContext context) {
    // Lista de números de emergencia
    final List<Map<String, String>> emergencyNumbers = [
      {'name': 'Policía', 'number': '+57 123'},
      {'name': 'Bomberos', 'number': '+57 456'},
      {'name': 'Ambulancia', 'number': '+57 789'},
      {'name': 'Cruz Roja', 'number': '+57 101'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Números de Emergencia'),
      ),
      body: ListView.builder(
        itemCount: emergencyNumbers.length,
        itemBuilder: (context, index) {
          final emergency = emergencyNumbers[index];

          return ListTile(
            leading: Icon(Icons.phone, color: Colors.green), // Ícono de teléfono
            title: Text(emergency['name'] ?? 'Desconocido'),
            subtitle: Text(emergency['number'] ?? ''),
            trailing: IconButton(
              icon: Icon(Icons.call, color: Colors.blue), // Botón de llamada
              onPressed: () {
                _makePhoneCall(emergency['number'] ?? '');
              },
            ),
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ListPhone(),
  ));
}
