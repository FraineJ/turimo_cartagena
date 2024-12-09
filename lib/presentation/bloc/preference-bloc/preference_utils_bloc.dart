import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';


abstract class LanguageEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ChangeLanguageEvent extends LanguageEvent {
  final Locale locale;

  ChangeLanguageEvent(this.locale);

  @override
  List<Object> get props => [locale];
}

class LoadInitialLanguageEvent extends LanguageEvent {}


class LanguageState extends Equatable {
  final Locale locale;

  const LanguageState(this.locale);

  @override
  List<Object> get props => [locale];
}


class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(const LanguageState(Locale('es'))) {
    on<ChangeLanguageEvent>((event, emit) {
      emit(LanguageState(event.locale));
    });

    on<LoadInitialLanguageEvent>((event, emit) {
      emit(const LanguageState(Locale('es'))); // Cambia esto según sea necesario
    });
  }
}
