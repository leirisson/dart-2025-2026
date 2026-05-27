import 'package:flutter/material.dart';

void main() {
  runApp(AppWidget());
}



class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.amber),
      home: HomePage()
    );
  }

}


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() {
   return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  int counter = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: GestureDetector(
          child: Text("Fluterando com Flutter !✅ - $counter"),
          onTap: (){
            setState(() {
              counter++;
            });
          },
        ),
      ),
    );
  }
}
