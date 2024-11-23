import 'package:flutter/material.dart';

class InputTextCustom extends StatefulWidget {
  final String hintText;
  final String? labelText;
  final TextEditingController controller;
  final IconData? suffixIcon;
  final IconData? prefixIcon;
  final bool isPassword;
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
    this.isRequired = false,
    this.requiredText,
    this.keyboardType = TextInputType.text,
    this.minLength,
    this.borderRadio,
    this.maxLines,
    this.readonly = false
  }) : super(key: key);

  @override
  _InputTextCustomState createState() => _InputTextCustomState();
}

class _InputTextCustomState extends State<InputTextCustom> {
  bool _obscureText = true;
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _obscureText && widget.isPassword,
      controller: widget.controller,
      autofocus: false,
      keyboardType: widget.keyboardType,
      readOnly: widget.readonly,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadio ?? 8),
        ),
        hintText: widget.hintText,
        labelText: widget.labelText,
        prefixIcon: widget.prefixIcon != null  ? Icon(widget.prefixIcon) : null,
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
            : Icon(widget.suffixIcon),
        errorText: _errorMessage,
      ),
      validator: (value) {
        if (widget.isRequired && (value == null || value.isEmpty)) {
          return widget.requiredText ?? 'Este campo es requerido';
        }
        if (widget.minLength != null &&
            value != null &&
            value.length < widget.minLength!) {
          return 'Debe tener al menos ${widget.minLength} caracteres';
        }
        return null;
      },
      onChanged: (value) {


      },
    );
  }
}
