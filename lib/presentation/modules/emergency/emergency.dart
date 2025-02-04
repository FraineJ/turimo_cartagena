import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Emergency extends StatelessWidget {
  const Emergency({super.key});


  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> emergencyNumbers = [
      {'name': 'Policía', 'number': '+57 123'},
      {'name': 'Movilidad y Acidentes', 'number': '+57 127'},
      {'name': 'Cruz roja', 'number': '+57 132'},
      {'name': 'ICBF', 'number': '+57 141'},
      {'name': 'Guala Ejército', 'number': '+57 147'},
      {'name': 'Bomberos', 'number': '+57 119'},
      {'name': 'Fuga de gas', 'number': '+57 164'},
      {'name': 'Guala Policía', 'number': '+57 165'},
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
            leading: Icon(Icons.phone, color: Colors.green),
            title: Text(emergency['name'] ?? 'Desconocido'),
            subtitle: Text(emergency['number'] ?? ''),
            trailing: IconButton(
              icon: Icon(Icons.call, color: Colors.blue),
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
