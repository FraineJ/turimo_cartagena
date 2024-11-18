import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_cartagena/presentation/bloc/preference-bloc/preference_utils_bloc.dart';


class LanguageSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: DropdownButton<Locale>(
        value: context.read<LanguageBloc>().state.locale,
        isExpanded: true,
        underline: SizedBox.shrink(), // Quita la línea inferior (borde)
        items:  [

          DropdownMenuItem(

            value: Locale('en'),
            child: Row(
              children: [
                Image.network( 'https://vectorflags.s3-us-west-2.amazonaws.com/flags/us-circle-01.png', // Bandera de España
                  width: 32,
                  height: 32,
                ),
                const SizedBox(width: 8),
                const Text('English',
                  style:  TextStyle(
                    fontSize: 24
                  ),

                ),
              ],
            ),
          ),
          DropdownMenuItem(
            value: Locale('es', 'ES'),
            child: Row(
              children: [
                Image.network('https://vectorflags.s3.amazonaws.com/flags/es-circle-01.png', // Bandera de España
                  width: 32,
                  height: 32,
                ),
                const SizedBox(width: 8),
                const Text('Español',
                  style:  TextStyle(
                      fontSize: 24
                  ),
                ),
              ],
            ),
          ),
        ],
        onChanged: (locale) {
          if (locale != null) {
            context.read<LanguageBloc>().add(ChangeLanguageEvent(locale));
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
