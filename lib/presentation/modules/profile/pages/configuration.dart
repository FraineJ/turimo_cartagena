import 'dart:io';
import 'package:flutter/material.dart';
import 'package:turismo_cartagena/generated/l10n.dart';
import 'package:turismo_cartagena/core/widgets/all-widgets.dart' as GLOBAL;
import 'package:turismo_cartagena/core/utils/all.dart' as SHARED;


class Configuration extends StatelessWidget {
  const Configuration({super.key});



  @override
  Widget build(BuildContext context) {

    Future navigationWed(String link) async {
      if (Platform.isIOS) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GLOBAL.WebPageViewer(
              url: link,
              title: S.current.settings,
            ),
          ),
        );
      } else {
        SHARED.Utils.launchURL(context, Uri.parse(link), true);
      }
    }

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GLOBAL.AppBarCustom(
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
              GLOBAL.RegistrationButton(
                width: double.infinity,
                color: Colors.red,
                text: S.current.textContinue ,
                onPressed: () {
                  navigationWed("https://www.gooway.co/eliminacion-de-cuenta/");
                  //SHARED.Utils.launchURL(context, Uri.parse("https://www.gooway.co/eliminacion-de-cuenta/"), false);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
