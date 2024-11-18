// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `¿A dónde quieres ir hoy?`
  String get where_to_go_today {
    return Intl.message(
      '¿A dónde quieres ir hoy?',
      name: 'where_to_go_today',
      desc: '',
      args: [],
    );
  }

  /// `Lugares`
  String get places {
    return Intl.message(
      'Lugares',
      name: 'places',
      desc: '',
      args: [],
    );
  }

  /// `Explorar`
  String get Explore {
    return Intl.message(
      'Explorar',
      name: 'Explore',
      desc: '',
      args: [],
    );
  }

  /// `Favoritos`
  String get Favorites {
    return Intl.message(
      'Favoritos',
      name: 'Favorites',
      desc: '',
      args: [],
    );
  }

  /// `Viajes`
  String get Trips {
    return Intl.message(
      'Viajes',
      name: 'Trips',
      desc: '',
      args: [],
    );
  }

  /// `Perfil`
  String get Profile {
    return Intl.message(
      'Perfil',
      name: 'Profile',
      desc: '',
      args: [],
    );
  }

  /// `Inicia sesión para ver tus favoritos`
  String get login_view_favorites {
    return Intl.message(
      'Inicia sesión para ver tus favoritos',
      name: 'login_view_favorites',
      desc: '',
      args: [],
    );
  }

  /// `Aún no has agregado ningún lugar a tus favoritos. ¡Explora y añade tus lugares preferidos!`
  String get login_view_favorites_place {
    return Intl.message(
      'Aún no has agregado ningún lugar a tus favoritos. ¡Explora y añade tus lugares preferidos!',
      name: 'login_view_favorites_place',
      desc: '',
      args: [],
    );
  }

  /// `Puedes crear, consultar o editar tus lugares favoritos una vez que hayas iniciado sesión.`
  String get login_for_create_favorites {
    return Intl.message(
      'Puedes crear, consultar o editar tus lugares favoritos una vez que hayas iniciado sesión.',
      name: 'login_for_create_favorites',
      desc: '',
      args: [],
    );
  }

  /// `Cerrar sesión`
  String get log_out {
    return Intl.message(
      'Cerrar sesión',
      name: 'log_out',
      desc: '',
      args: [],
    );
  }

  /// `Idiomas`
  String get languages {
    return Intl.message(
      'Idiomas',
      name: 'languages',
      desc: '',
      args: [],
    );
  }

  /// `Seleccionar idioma`
  String get select_languages {
    return Intl.message(
      'Seleccionar idioma',
      name: 'select_languages',
      desc: '',
      args: [],
    );
  }

  /// `Actualización de información`
  String get update_information_user {
    return Intl.message(
      'Actualización de información',
      name: 'update_information_user',
      desc: '',
      args: [],
    );
  }

  /// `Configuración`
  String get settings {
    return Intl.message(
      'Configuración',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Eventos`
  String get event {
    return Intl.message(
      'Eventos',
      name: 'event',
      desc: '',
      args: [],
    );
  }

  /// `Inicia sesión para ver tu perfil`
  String get login_view_profile {
    return Intl.message(
      'Inicia sesión para ver tu perfil',
      name: 'login_view_profile',
      desc: '',
      args: [],
    );
  }

  /// `Inicia sesión para ver tu información y tus ajustes`
  String get login_view_detail_profile {
    return Intl.message(
      'Inicia sesión para ver tu información y tus ajustes',
      name: 'login_view_detail_profile',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'es', countryCode: 'ES'),
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
