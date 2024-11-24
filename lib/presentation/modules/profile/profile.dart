import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turismo_cartagena/article_injection.dart';
import 'package:turismo_cartagena/generated/l10n.dart';
import 'package:turismo_cartagena/presentation/bloc/initial-bloc/initial_bloc.dart';
import 'package:turismo_cartagena/presentation/modules/auth/login/login.dart';
import 'package:turismo_cartagena/presentation/global/widgets/all-widgets.dart' as Widgets;
import 'package:turismo_cartagena/presentation/modules/profile/widgets/language-selector.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  Future<void> logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();

    LoadingOverlay.show(context);
    await Future.delayed(Duration(seconds: 3), () {
      LoadingOverlay.hide();
    });

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Login()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: BlocProvider(
            create: (context) => InitialBloc(sl())..add(AppInitialEvent()),
            child: BlocBuilder<InitialBloc, InitialState>(
              builder: (context, state) {
                if (state is IsAuthenticatedSuccess) {
                  // Aquí deberías mostrar el contenido cuando el usuario esté autenticado
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Widgets.AppBarCustom(
                          textTitle: S.current.Profile,
                          botonVolver: false,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: Row(
                          children: [
                            const CircleAvatar(
                              radius: 45,
                              backgroundImage: AssetImage("assets/images/default-user.jpeg"),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 20,
                              ),
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                    maxWidth: MediaQuery.of(context).size.width - 170),
                                child: const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Frainer",
                                      style: TextStyle(
                                          fontSize: 25, fontWeight: FontWeight.w500),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                    const Text("frainer2013@gmail.com"),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            ListTile(
                              leading: const Icon(
                                Icons.edit_outlined,
                                color: Color(0xFF22014D),
                              ),
                              title: Text(S.current.update_information_user,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                            ListTile(
                              onTap: () {
                                showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) => Center(
                                        child: Dialog(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(12.0),
                                            ),
                                            child: Container(
                                              width: MediaQuery.of(context).size.width * 0.8,
                                              height:
                                              MediaQuery.of(context).size.height * 0.3,
                                              padding: const EdgeInsets.all(16),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(
                                                        S.current.select_languages,
                                                        style: const TextStyle(
                                                          fontWeight: FontWeight.w800,
                                                          fontSize: 24,
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          Navigator.of(context).pop();
                                                        },
                                                        child: Container(
                                                          width: 40,
                                                          height: 40,
                                                          decoration: BoxDecoration(
                                                            shape: BoxShape.circle,
                                                            color: Colors.grey[200],
                                                          ),
                                                          child: const Icon(
                                                            Icons.clear,
                                                            color: Color(0xFFFF6969),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 16,
                                                  ),
                                                  LanguageSelector(),
                                                ],
                                              ),
                                            )
                                        )
                                    )
                                );
                              },
                              leading: const Icon(
                                Icons.translate_rounded,
                                color: Color(0xFF22014D),
                              ),
                              title: Text(S.current.languages,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                            ListTile(
                              leading: const Icon(Icons.settings_outlined,
                                  color: const Color(0xFF22014D)),
                              title: Text(S.current.settings,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                          ],
                        ),
                      ),
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: ListTile(
                          leading: const Icon(
                            Icons.logout_outlined,
                            color: Color(0xFFFF6969),
                            size: 30,
                          ),
                          title: Text(S.current.log_out,
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFFF6969))),
                          onTap: () {
                            logout(context);
                          },
                        ),
                      ),
                    ],
                  );
                } else if (state is IsAuthenticatedFailure) {
                  // Aquí muestra el estado cuando no está autenticado
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Widgets.AppBarCustom(
                          textTitle: S.current.Profile, botonVolver: false),
                      Widgets.RequestLogin(
                        title: S.current.login_view_favorites,
                        description: S.current.login_view_detail_profile,
                      ),
                    ],
                  );
                }
                // Mientras el estado se resuelve, muestra un indicador de carga
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ),
      ),
    );
  }
}

class LoadingOverlay {
  static OverlayEntry? _overlayEntry;

  static void show(BuildContext context) {
    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) {
        return Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                onTap: () {
                  hide();
                },
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
            ),
            const Positioned.fill(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ],
        );
      },
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  static void hide() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
