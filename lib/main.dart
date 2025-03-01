import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:turismo_cartagena/core/di/article_injection.dart';
import 'package:turismo_cartagena/presentation/bloc/initial-bloc/initial_bloc.dart';
import 'package:turismo_cartagena/presentation/bloc/preference-bloc/preference_utils_bloc.dart';
import 'package:turismo_cartagena/presentation/modules/layuot.dart';
import 'core/theme/sizes.dart';
import 'core/theme/theme.dart';
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
          return  MaterialApp(
            title: 'Gooway',
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            locale: state.locale,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            home: Builder(
              builder: (context) {
                AppSizes.init(context); // Inicializa las dimensiones aquí
                return Layout();
              },
            ),
          );
        },
      ),
    );
  }
}
