import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:turismo_cartagena/article_injection.dart';
import 'package:turismo_cartagena/presentation/bloc/initial-bloc/initial_bloc.dart';
import 'package:turismo_cartagena/presentation/bloc/preference-bloc/preference_utils_bloc.dart';
import 'package:turismo_cartagena/presentation/modules/layuot.dart';
import 'generated/l10n.dart';
import 'infrastructure/services/firebase-notification.service.dart';


void main() async {
  initArticlesInjections();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseApiNotification().initNotifications();
  runApp(
      MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => InitialBloc())
          ],
          child: const MyApp()
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<InitialBloc>(
          create: (context) => InitialBloc()..add(AppInitialEvent()),
        ),
        BlocProvider<LanguageBloc>(
          create: (context) => LanguageBloc()..add(LoadInitialLanguageEvent()),
        ),
      ],
      child: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Gooway',
            localizationsDelegates: [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            locale: state.locale,  // Aquí se actualiza el idioma según el estado
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.green,
              colorScheme: ColorScheme.fromSeed(
                seedColor: const Color(0xFFF5F6F8),
              ),
            ),
            home: Layout(),
          );
        },
      ),
    );
  }
}
