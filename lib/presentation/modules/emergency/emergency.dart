import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/theme/colors.dart';

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
      {'name': 'Policía', 'number': '+57 123', 'logos': 'assets/images/logos-entidades/logo-policia.webp'},
      {'name': 'Cruz Roja', 'number': '+57 132', 'logos': 'assets/images/logos-entidades/log-cruz-roja.webp'},
      {'name': 'ICBF', 'number': '+57 141', 'logos': 'assets/images/logos-entidades/logo-ibf.webp'},
      {'name': 'Gaula Ejército', 'number': '+57 147', 'logos': 'assets/images/logos-entidades/logo-gaula.webp'},

      {'name': 'Bomberos', 'number': '+57 119', 'logos': 'assets/images/logos-entidades/logo-bombero.webp'},
      {'name': 'Fiscalía General de la Nación', 'number': '+57 122', 'logos': 'assets/images/logos-entidades/logo-fiscalia.webp'},
      {'name': 'Defenza Civil', 'number': '+57 144', 'logos': 'assets/images/logos-entidades/logo-defenza-civil.jpg'},

      {'name': 'Gaula Policía', 'number': '+57 165', 'logos': 'assets/images/logos-entidades/logo-gaula.webp'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Números de Emergencia'),
      ),
      body: ListView.builder(
        itemCount: emergencyNumbers.length,
        itemBuilder: (context, index) {
          final emergency = emergencyNumbers[index];

          return ListTile(
            leading: ClipOval(
              child: Image.asset(
                emergency['logos'] ?? 'assets/images/default.png',
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(emergency['name'] ?? 'Desconocido'),
            subtitle: Text(emergency['number'] ?? ''),
            trailing: IconButton(
              icon:  Icon(Icons.call, color: AppColors.primary),
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
