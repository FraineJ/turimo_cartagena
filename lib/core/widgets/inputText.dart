import 'package:flutter/material.dart';

class InputTextCustom extends StatefulWidget {
  final String hintText;
  final String? labelText;
  final TextEditingController controller;
  final IconData? suffixIcon;
  final IconData? prefixIcon;
  final bool isPassword;
  final bool isEmail;
  final bool isRequired;
  final String? requiredText;
  final TextInputType keyboardType;
  final int? minLength;
  double? borderRadio = 8.0;
  int? maxLines = 1;
  bool readonly;

  InputTextCustom({
    Key? key,
    required this.hintText,
    this.labelText,
    required this.controller,
    this.suffixIcon,
    this.prefixIcon,
    this.isPassword = false,
    this.isEmail = false,
    this.isRequired = false,
    this.requiredText,
    this.keyboardType = TextInputType.text,
    this.minLength,
    this.borderRadio,
    this.maxLines,
    this.readonly = false,
  }) : super(key: key);

  @override
  _InputTextCustomState createState() => _InputTextCustomState();
}

class _InputTextCustomState extends State<InputTextCustom> {
  bool _obscureText = true;
  String? _errorMessage;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode(); // Inicializa el nodo de foco
  }

  @override
  void dispose() {
    _focusNode.dispose(); // Libera el recurso
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'El correo electrónico es obligatorio';
    }
    final emailRegex =
    RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Por favor, ingresa un correo electrónico válido';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _obscureText && widget.isPassword,
      controller: widget.controller,
      autofocus: false,
      focusNode: _focusNode, // Asigna el nodo de foco
      keyboardType: widget.keyboardType,
      readOnly: widget.readonly,
      textInputAction: TextInputAction.next, // Permite pasar al siguiente campo
      onFieldSubmitted: (_) {
        FocusScope.of(context).nextFocus(); // Mueve el foco al siguiente campo
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadio ?? 8),
        ),
        hintText: widget.hintText,
        labelText: widget.labelText,
        prefixIcon:
        widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
        suffixIcon: widget.isPassword
            ? IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        )
            : widget.suffixIcon != null
            ? Icon(widget.suffixIcon)
            : null,
        errorText: _errorMessage,
      ),
      validator: widget.isRequired == true
          ? (value) {
        if (widget.isRequired && (value == null || value.isEmpty)) {
          return widget.requiredText ?? 'Este campo es requerido';
        }
        if (widget.minLength != null &&
            value != null &&
            value.length < widget.minLength!) {
          return 'Debe tener al menos ${widget.minLength} caracteres';
        }
        return null;
      }
          : widget.isEmail == true
          ? _validateEmail
          : null,
    );
  }
}
