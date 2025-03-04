import 'package:flutter/material.dart';
import 'package:turismo_cartagena/core/theme/colors.dart';

import '../theme/sizes.dart';

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
    this.readonly = false
  }) : super(key: key);

  @override
  _InputTextCustomState createState() => _InputTextCustomState();
}

class _InputTextCustomState extends State<InputTextCustom> {
  bool _obscureText = true;
  String? _errorMessage;

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'El correo electrónico es obligatorio';
    }
    // Expresión regular para un correo válido
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Por favor, ingresa un correo electrónico válido';
    }
    return null; // Devuelve null si no hay errores
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _obscureText && widget.isPassword,
      controller: widget.controller,
      autofocus: false,
      keyboardType: widget.keyboardType,
      readOnly: widget.readonly,
      style: TextStyle(
          fontFamily: 'Inter',
          color: AppColors.primaryTextColor,
          fontWeight: FontWeight.w400,
          fontSize: AppSizes.textMedium
      ),
      decoration: InputDecoration(

        border: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: Colors.grey.withValues(alpha: 0.08),
          ),
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusSmall),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: Colors.grey.withOpacity(0.5), // Color del borde cuando está inactivo
          ),
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusSmall),
        ),

        hintText: widget.hintText,
        hintStyle:  TextStyle(
          color: Colors.grey,
          fontSize: AppSizes.textSmall,
        ),
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
      validator: widget.isRequired == true ? (value) {
        if (widget.isRequired && (value == null || value.isEmpty)) {
          return widget.requiredText ?? 'Este campo es requerido';
        }
        if (widget.minLength != null &&
            value != null &&
            value.length < widget.minLength!) {
          return 'Debe tener al menos ${widget.minLength} caracteres';
        }
        return null;
      } : widget.isEmail == true ?  _validateEmail : null,
      onChanged: (value) {


      },
    );
  }
}
