
import 'dart:ui';

import 'package:turismo_cartagena/domain/repositorys/utils.repository.dart';

class UtilsCaseUse {

  final UtilsRepository _utilsRepository;
  UtilsCaseUse(this._utilsRepository);

  Future convertCopToDolar(double value)async {
    return this._utilsRepository.convertCopToDolar(value);
  }

  Future<Locale> saveLocales(Locale locale) async {
    await this._utilsRepository.saveLocales(locale);
    return locale; // Return the locale back
  }

  Future<Locale> get locale {
      return this._utilsRepository.locale;
  }

}