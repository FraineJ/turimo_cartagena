part of 'initial_bloc.dart';

class InitialState extends Equatable {

  final bool isAuthenticated;
  bool get isLoginApp => isAuthenticated;

  const InitialState({
    required this.isAuthenticated
  });

  InitialState copyWith({
    bool? isAuthenticated,
  }) => InitialState (
    isAuthenticated: isAuthenticated ?? this.isAuthenticated,
  );

  @override
  List<Object?> get props => [isAuthenticated];

}

