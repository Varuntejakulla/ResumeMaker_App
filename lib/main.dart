
import 'package:flutter/material.dart';
import 'package:resume_looks/login_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://sdmplxytepuzhlhpobaq.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNkbXBseHl0ZXB1emhsaHBvYmFxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDUwNjMxNDEsImV4cCI6MjA2MDYzOTE0MX0.AJeIKiGgSFSHxH4kmKfz4eXprHDnzP4q3BmNyRAMKTM',
  );
  runApp(const Myflutter());
}

class Myflutter extends StatelessWidget {
  const Myflutter({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Language x ',
      theme: ThemeData(primaryColor: const Color.fromARGB(255, 19, 64, 42)),
      home:const LoginPage(),
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


