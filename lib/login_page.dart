import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> login() async {
  try {
    final email = usernameController.text.trim();
    final password = passwordController.text;

    // 1. Check if user exists in users table
    final userQuery = await Supabase.instance.client
        .from('users') // <-- your table name
        .select()
        .eq('email', email)
        .maybeSingle(); // fetch single user or null

    if (userQuery == null) {
      _showSnackBar('User does not exist');
      return;
    }

    // 2. Try login
    final response = await Supabase.instance.client.auth.signInWithPassword(
      email: email,
      password: password,
    );

    if (response.session != null) {
      _showSnackBar('Login successful!', bgColor: Colors.green, icon: Icons.check);
      // TODO: Navigate to dashboard or home screen
    } else {
      _showSnackBar('Invalid credentials');
    }

  } on AuthException catch (e) {
    _showSnackBar(e.message);
  } catch (e) {
    _showSnackBar('Something went wrong');
  }
}


  void _showSnackBar(String message, {Color bgColor = Colors.red, IconData? icon}) {
    final snackBar = SnackBar(
      content: Row(
        children: [
          if (icon != null) Icon(icon, color: Colors.white),
          const SizedBox(width: 10),
          Expanded(child: Text(message)),
        ],
      ),
      backgroundColor: bgColor,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double width = size.width;
    final bool isWeb = width > 600;
    final double padding = isWeb ? width * 0.3 : width * 0.08;
    final double titleFont = isWeb ? 32 : width * 0.08;
    final double textFieldFont = isWeb ? 16 : 18;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 224, 226, 229),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: padding),
          child: SlideTransition(
            position: _slideAnimation,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Login',
                    style: TextStyle(
                      fontSize: titleFont,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 32, 6, 79),
                    ),
                  ),
                  SizedBox(height: isWeb ? 32 : size.height * 0.04),
                  TextField(
                    controller: usernameController,
                    style: TextStyle(fontSize: textFieldFont),
                    decoration: InputDecoration(
                      labelText: 'Username',
                      labelStyle: TextStyle(fontSize: textFieldFont),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      prefixIcon: const Icon(Icons.person),
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    style: TextStyle(fontSize: textFieldFont),
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(fontSize: textFieldFont),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      prefixIcon: const Icon(Icons.lock),
                    ),
                  ),
                  SizedBox(height: size.height * 0.04),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 59, 17, 186),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: const Text('Login', style: TextStyle(fontSize: 16)),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const RegisterPage()),
                      );
                    },
                    child: const Text("Don't have an account? Register"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
