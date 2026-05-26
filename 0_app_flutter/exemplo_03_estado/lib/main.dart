

import 'package:flutter/material.dart';

void main(){
  runApp(AppWidget("Flutter 123"));
}


class AppWidget extends StatelessWidget {
 final String texto;
 AppWidget(this.texto);

  @override
  Widget build(BuildContext context) {
   


   return Container(
    child: Center(
      child: Text(
        texto,
        textDirection: TextDirection.ltr,
        style: TextStyle(color: Colors.white, fontSize: 45)
        ),
    ),
   );
  }
}