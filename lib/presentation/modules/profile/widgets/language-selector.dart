import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_cartagena/presentation/bloc/preference-bloc/preference_utils_bloc.dart';

class LanguageSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Obtener idioma actual
    final currentLocale = context.read<LanguageBloc>().state.locale;

    return Material(
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLanguageOption(
            context: context,
            locale: Locale('en'),
            flagUrl: 'https://vectorflags.s3-us-west-2.amazonaws.com/flags/us-circle-01.png',
            label: 'English',
            isSelected: currentLocale.languageCode == 'en',
          ),
          const SizedBox(height: 16),
          _buildLanguageOption(
            context: context,
            locale: Locale('es'),
            flagUrl: 'https://vectorflags.s3.amazonaws.com/flags/es-circle-01.png',
            label: 'Español',
            isSelected: currentLocale.languageCode == 'es',
          ),
        ],
      ),
    );
  }

  // Widget para cada opción de idioma
  Widget _buildLanguageOption({
    required BuildContext context,
    required Locale locale,
    required String flagUrl,
    required String label,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () {
        context.read<LanguageBloc>().add(ChangeLanguageEvent(locale));
        Navigator.pop(context);
      },
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Colors.green.withOpacity(0.1) : Colors.white,
          border: Border.all(
            color: isSelected ? Colors.green : Colors.grey.shade300,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          children: [
            // Icono de la bandera
            Image.network(
              flagUrl,
              width: 40,
              height: 40,
            ),
            const SizedBox(width: 16),
            // Nombre del idioma
            Text(
              label,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.green : Colors.black87,
              ),
            ),
            const Spacer(),
            // Icono de selección (si está seleccionado)
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: Colors.green,
              ),
          ],
        ),
      ),
    );
  }
}
