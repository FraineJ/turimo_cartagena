import 'package:flutter/material.dart';

class PasswordValidatorWidget extends StatefulWidget {
  final TextEditingController controller;

  const PasswordValidatorWidget({Key? key, required this.controller})
      : super(key: key);

  @override
  _PasswordValidatorWidgetState createState() =>
      _PasswordValidatorWidgetState();
}

class _PasswordValidatorWidgetState extends State<PasswordValidatorWidget> {
  bool _hasUppercase = false;
  bool _hasSpecialCharacter = false;
  bool _hasMinLength = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_validatePassword); // Escuchar cambios en el controlador
  }

  void _validatePassword() {
    final password = widget.controller.text;
    setState(() {
      _hasUppercase = password.contains(RegExp(r'[A-Z]'));
      _hasSpecialCharacter = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
      _hasMinLength = password.length > 6;
    });
  }

  @override
  void dispose() {
    widget.controller.removeListener(_validatePassword); // Deja de escuchar cambios
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tu contraseña debe cumplir con los siguientes requisitos:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Icon(
              _hasUppercase ? Icons.check_circle : Icons.cancel,
              color: _hasUppercase ? Colors.green : Colors.red,
            ),
            const SizedBox(width: 8),
            Text('Al menos una mayúscula'),
          ],
        ),
        Row(
          children: [
            Icon(
              _hasSpecialCharacter ? Icons.check_circle : Icons.cancel,
              color: _hasSpecialCharacter ? Colors.green : Colors.red,
            ),
            const SizedBox(width: 8),
            Text('Al menos un carácter especial'),
          ],
        ),
        Row(
          children: [
            Icon(
              _hasMinLength ? Icons.circle : Icons.cancel,
              color: _hasMinLength ? Colors.green : Colors.red,
            ),
            const SizedBox(width: 8),
            Text('Más de 6 caracteres'),
          ],
        ),
      ],
    );
  }
}
