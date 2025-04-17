
import 'package:flutter/material.dart';


void main() {
  runApp(Myflutter());
}

class Myflutter extends StatelessWidget {
  const Myflutter({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Language x ',
      theme: ThemeData(primaryColor: const Color.fromARGB(255, 19, 64, 42)),
      home: Dashboard(),
    );
  }
}

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
      ),
      body:
      Center(
      child: SizedBox(
        child: Text("Guys please satrt the project \n Hari \n sai  \n project loading .....",style: TextStyle(fontWeight: FontWeight.bold),
        ) ,
      ),
      )
    );
  }
}


