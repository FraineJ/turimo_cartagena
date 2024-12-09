import 'package:flutter/material.dart';
import 'package:turismo_cartagena/generated/l10n.dart';
import 'package:turismo_cartagena/presentation/global/widgets/app-bar-custom.dart';
import 'package:turismo_cartagena/presentation/global/widgets/button-outlined.dart';
import 'package:turismo_cartagena/presentation/global/utils/all.dart' as SHARED;


class Configuration extends StatelessWidget {
  const Configuration({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBarCustom(
                textTitle: S.current.settings,
                botonVolver: true,
              ),
              const SizedBox(
                height: 16,
              ),
              Text(S.current.deleteAccount,
                  style: const  TextStyle(
                    fontSize: 20,

                    fontWeight: FontWeight.bold,
                  )
              ),
              const SizedBox(
                height: 16,
              ),
              Text(S.current.deleteAccountMessage),
              const SizedBox(
                height: 16,
              ),
              RegistrationButton(
                width: double.infinity,
                color: Colors.red,
                text: S.current.textContinue ,
                onPressed: () {
                  SHARED.Utils.launchURL(Uri.parse("https://www.gooway.co/eliminacion-de-cuenta/"), false);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
