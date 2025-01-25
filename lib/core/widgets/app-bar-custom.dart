import 'package:flutter/material.dart';

class AppBarCustom extends StatelessWidget {

  final String textTitle;
  final bool? botonVolver;

  const AppBarCustom({Key? key, required this.textTitle, this.botonVolver = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:  16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Text(textTitle,
              style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold
              )
          ),
          botonVolver == true  ? InkWell(
            onTap: (){
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
          ): Container(),
        ],
      ),
    );
  }
}
