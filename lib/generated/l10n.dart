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

  /// `Inicio`
  String get Home {
    return Intl.message(
      'Inicio',
      name: 'Home',
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

  /// `Nombre`
  String get nameRegister {
    return Intl.message(
      'Nombre',
      name: 'nameRegister',
      desc: '',
      args: [],
    );
  }

  /// `Apellidos`
  String get lastNameRegister {
    return Intl.message(
      'Apellidos',
      name: 'lastNameRegister',
      desc: '',
      args: [],
    );
  }

  /// `Correo electrónico`
  String get emailRegister {
    return Intl.message(
      'Correo electrónico',
      name: 'emailRegister',
      desc: '',
      args: [],
    );
  }

  /// `Ingrese su contraseña`
  String get passwordRegister {
    return Intl.message(
      'Ingrese su contraseña',
      name: 'passwordRegister',
      desc: '',
      args: [],
    );
  }

  /// `Confirmar contraseña`
  String get confirmPasswordRegister {
    return Intl.message(
      'Confirmar contraseña',
      name: 'confirmPasswordRegister',
      desc: '',
      args: [],
    );
  }

  /// `Al hacer clic en 'Registrarse', aceptas nuestras Condiciones y`
  String get messagePolityOne {
    return Intl.message(
      'Al hacer clic en \'Registrarse\', aceptas nuestras Condiciones y',
      name: 'messagePolityOne',
      desc: '',
      args: [],
    );
  }

  /// `Politicas de privacidad`
  String get messagePolityTow {
    return Intl.message(
      'Politicas de privacidad',
      name: 'messagePolityTow',
      desc: '',
      args: [],
    );
  }

  /// `Ingrese su nombre`
  String get hintTextName {
    return Intl.message(
      'Ingrese su nombre',
      name: 'hintTextName',
      desc: '',
      args: [],
    );
  }

  /// `Ingrese sus apellidos`
  String get hintTextLastName {
    return Intl.message(
      'Ingrese sus apellidos',
      name: 'hintTextLastName',
      desc: '',
      args: [],
    );
  }

  /// `Ingrese un correo electrónico`
  String get hintTextEmail {
    return Intl.message(
      'Ingrese un correo electrónico',
      name: 'hintTextEmail',
      desc: '',
      args: [],
    );
  }

  /// `Contraseña`
  String get hintTexPassword {
    return Intl.message(
      'Contraseña',
      name: 'hintTexPassword',
      desc: '',
      args: [],
    );
  }

  /// `Descripción`
  String get description {
    return Intl.message(
      'Descripción',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Contacto`
  String get contact {
    return Intl.message(
      'Contacto',
      name: 'contact',
      desc: '',
      args: [],
    );
  }

  /// `Pulsa en cualquiera de los iconos para comunicarse.`
  String get sendLinkContact {
    return Intl.message(
      'Pulsa en cualquiera de los iconos para comunicarse.',
      name: 'sendLinkContact',
      desc: '',
      args: [],
    );
  }

  /// `De momento no hay eventos disponibles.`
  String get noFoundEvent {
    return Intl.message(
      'De momento no hay eventos disponibles.',
      name: 'noFoundEvent',
      desc: '',
      args: [],
    );
  }

  /// `Reintentar`
  String get retry {
    return Intl.message(
      'Reintentar',
      name: 'retry',
      desc: '',
      args: [],
    );
  }

  /// `Eliminar cuenta`
  String get deleteAccount {
    return Intl.message(
      'Eliminar cuenta',
      name: 'deleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `La eliminación de la cuenta es definitiva. Si elimina tu cuanta de Gooway, no podras recuperarla el contenido ni la información que nos compartistes, tambien se eliminara Tus favoritos y reseñas`
  String get deleteAccountMessage {
    return Intl.message(
      'La eliminación de la cuenta es definitiva. Si elimina tu cuanta de Gooway, no podras recuperarla el contenido ni la información que nos compartistes, tambien se eliminara Tus favoritos y reseñas',
      name: 'deleteAccountMessage',
      desc: '',
      args: [],
    );
  }

  /// `Continuar`
  String get textContinue {
    return Intl.message(
      'Continuar',
      name: 'textContinue',
      desc: '',
      args: [],
    );
  }

  /// `Ha ocurrido un error. Por favor, inténtalo más tarde.`
  String get errorServer {
    return Intl.message(
      'Ha ocurrido un error. Por favor, inténtalo más tarde.',
      name: 'errorServer',
      desc: '',
      args: [],
    );
  }

  /// `Al menos una mayúscula.`
  String get textValidateUppercase {
    return Intl.message(
      'Al menos una mayúscula.',
      name: 'textValidateUppercase',
      desc: '',
      args: [],
    );
  }

  /// `Tu contraseña debe cumplir con los siguientes requisitos:`
  String get textPasswordRequired {
    return Intl.message(
      'Tu contraseña debe cumplir con los siguientes requisitos:',
      name: 'textPasswordRequired',
      desc: '',
      args: [],
    );
  }

  /// `Al menos un carácter especial`
  String get characterSpecial {
    return Intl.message(
      'Al menos un carácter especial',
      name: 'characterSpecial',
      desc: '',
      args: [],
    );
  }

  /// `Más de 6 caracteres`
  String get sixCharacters {
    return Intl.message(
      'Más de 6 caracteres',
      name: 'sixCharacters',
      desc: '',
      args: [],
    );
  }

  /// `Usuario registrado`
  String get userRegister {
    return Intl.message(
      'Usuario registrado',
      name: 'userRegister',
      desc: '',
      args: [],
    );
  }

  /// `¡Tu cuenta se ha creado con éxito! Ahora puedes explorar y disfrutar de todo lo que tenemos para ti. ¡Bienvenido!`
  String get textSuccessRegister {
    return Intl.message(
      '¡Tu cuenta se ha creado con éxito! Ahora puedes explorar y disfrutar de todo lo que tenemos para ti. ¡Bienvenido!',
      name: 'textSuccessRegister',
      desc: '',
      args: [],
    );
  }

  /// `Las contraseñas no coinciden.`
  String get passwordNotMatch {
    return Intl.message(
      'Las contraseñas no coinciden.',
      name: 'passwordNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `La contraseña debe cumplir con los requisitos`
  String get passwordRequirements {
    return Intl.message(
      'La contraseña debe cumplir con los requisitos',
      name: 'passwordRequirements',
      desc: '',
      args: [],
    );
  }

  /// `Correo inválido`
  String get titleEmailInvalid {
    return Intl.message(
      'Correo inválido',
      name: 'titleEmailInvalid',
      desc: '',
      args: [],
    );
  }

  /// `El correo electrónico ingresado no es válido. Por favor, revisa y asegúrate de que esté correctamente escrito para continuar.`
  String get textEmailInvalid {
    return Intl.message(
      'El correo electrónico ingresado no es válido. Por favor, revisa y asegúrate de que esté correctamente escrito para continuar.',
      name: 'textEmailInvalid',
      desc: '',
      args: [],
    );
  }

  /// `Regresar`
  String get back {
    return Intl.message(
      'Regresar',
      name: 'back',
      desc: '',
      args: [],
    );
  }

  /// `Cancelar`
  String get cancel {
    return Intl.message(
      'Cancelar',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Contraseña Actualizada`
  String get updatePassword {
    return Intl.message(
      'Contraseña Actualizada',
      name: 'updatePassword',
      desc: '',
      args: [],
    );
  }

  /// `Tu contraseña se ha cambiado con éxito.`
  String get textUpdatePassword {
    return Intl.message(
      'Tu contraseña se ha cambiado con éxito.',
      name: 'textUpdatePassword',
      desc: '',
      args: [],
    );
  }

  /// `Ana`
  String get chatAna {
    return Intl.message(
      'Ana',
      name: 'chatAna',
      desc: '',
      args: [],
    );
  }

  /// `Detalles del Lugar`
  String get placeDetails {
    return Intl.message(
      'Detalles del Lugar',
      name: 'placeDetails',
      desc: '',
      args: [],
    );
  }

  /// `Publicidad`
  String get advertising {
    return Intl.message(
      'Publicidad',
      name: 'advertising',
      desc: '',
      args: [],
    );
  }

  /// `Iniciar sesión`
  String get textLogin {
    return Intl.message(
      'Iniciar sesión',
      name: 'textLogin',
      desc: '',
      args: [],
    );
  }

  /// `¿Olvidaste tu contraseña?`
  String get forgotYourPassword {
    return Intl.message(
      '¿Olvidaste tu contraseña?',
      name: 'forgotYourPassword',
      desc: '',
      args: [],
    );
  }

  /// `Registrate`
  String get signUp {
    return Intl.message(
      'Registrate',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `¿No tienes una cuenta? `
  String get notAccount {
    return Intl.message(
      '¿No tienes una cuenta? ',
      name: 'notAccount',
      desc: '',
      args: [],
    );
  }

  /// `Registrarse es gratis.!`
  String get registrationIsFree {
    return Intl.message(
      'Registrarse es gratis.!',
      name: 'registrationIsFree',
      desc: '',
      args: [],
    );
  }

  /// `Inicia sesión o regístrate`
  String get loginOrRegister {
    return Intl.message(
      'Inicia sesión o regístrate',
      name: 'loginOrRegister',
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
