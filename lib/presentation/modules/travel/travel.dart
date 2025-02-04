import 'package:flutter/material.dart';
import 'package:turismo_cartagena/core/widgets/all-widgets.dart' as Widgets;


class TravelView extends StatelessWidget {
  const TravelView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),

            child: const Column(
              children: [
                Widgets.AppBarCustom(textTitle: "Viajes", botonVolver: false,),
              ],
            ),
          )
      ),
    );
  }
}
