import 'package:turismo_cartagena/presentation/global/widgets/all-widgets.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatelessWidget {

  const ChangePassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          child: Padding(
            padding: const EdgeInsets.only(top:  40),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  const SizedBox(height: 40),
                  Transform.rotate(
                    angle: 0.8,
                    child: const CircleAvatar(
                      backgroundColor: Color.fromARGB(66, 193, 193, 193),
                      radius: 60,
                      child: Icon(Icons.key, size: 90,),
                    ),
                  ),
                  const SizedBox(height: 40),
                  const Text("Cambiar contraseña", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                  const Text("Ingrese su nueva contraseña abajo"),
                  const SizedBox(height: 40),
                  TextFormField(
                    // controller: username,
                    autofocus: false,
                    obscureText: true,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),

                      hintText: "Nueva contraseña",
                      prefixIcon: const Icon(
                          Icons.key
                      ),

                    ),
                    onChanged: (value) {
                    },
                  ),
                  const SizedBox(height: 20,),
                  TextFormField(
                    // controller: username,
                    autofocus: false,
                    obscureText: true,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                      hintText: "Confirmar contraseña",
                      prefixIcon: const Icon(
                          Icons.key
                      ),

                    ),
                    onChanged: (value) {
                    },
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ButtonPrimaryCustom(text: "Cancelar", onPressed: () {}, width: MediaQuery.of(context).size.width * 0.35),
                      const SizedBox(width: 10,),
                      ButtonPrimaryCustom(text: "Guardar", onPressed: () {}, color: Colors.indigo, width: MediaQuery.of(context).size.width * 0.35)
                    ],
                  ),
                  const SizedBox(height: 20,),
                ],
              ),
            ),
          ),
        )
    );
  }
}