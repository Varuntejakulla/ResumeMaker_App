import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
    final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  @override
  void dispose() {
   
    _controller.dispose();
     usernameController.dispose();
    passwordController.dispose();
    fullNameController.dispose();
   emailController.dispose();
   phoneController.dispose();
   
    confirmPasswordController.dispose();

    super.dispose();
  }

  Future<void> register() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('fullname', fullNameController.text);
await prefs.setString('email', emailController.text);
await prefs.setString('phone', phoneController.text);
await prefs.setString('username', usernameController.text);
await prefs.setString('password', passwordController.text);
   
    _showSnackBar('Registration Successful!', color: Colors.green, icon: Icons.check);
    await Future.delayed(const Duration(seconds: 1));
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginPage()));
  }

  void _showSnackBar(String message, {Color color = Colors.red, IconData icon = Icons.error}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 10),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    // Apply breakpoint for responsiveness
    bool isWeb = width > 600;
    double padding = isWeb ? width * 0.3 : width * 0.08;
    double titleFont = isWeb ? 28 : 32;
    double textFieldFont = isWeb ? 16 : 18;

    return Scaffold(
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: padding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
            children: [
  Text(
    'Create Account',
    style: TextStyle(
      fontSize: titleFont,
      fontWeight: FontWeight.bold,
      color: Colors.deepPurple,
    ),
  ),
  const SizedBox(height: 25),

  // Full Name
  TextField(
    controller: fullNameController,
    style: TextStyle(fontSize: textFieldFont),
    decoration: InputDecoration(
      labelText: 'Full Name',
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      prefixIcon: const Icon(Icons.account_circle),
    ),
  ),
  const SizedBox(height: 15),

  // Email
  TextField(
    controller: emailController,
    keyboardType: TextInputType.emailAddress,
    style: TextStyle(fontSize: textFieldFont),
    decoration: InputDecoration(
      labelText: 'Email',
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      prefixIcon: const Icon(Icons.email),
    ),
  ),
  const SizedBox(height: 15),

  // Phone
  TextField(
    controller: phoneController,
    keyboardType: TextInputType.phone,
    style: TextStyle(fontSize: textFieldFont),
    decoration: InputDecoration(
      labelText: 'Phone Number',
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      prefixIcon: const Icon(Icons.phone),
    ),
  ),
  const SizedBox(height: 15),

  // Username
  TextField(
    controller: usernameController,
    style: TextStyle(fontSize: textFieldFont),
    decoration: InputDecoration(
      labelText: 'Username',
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      prefixIcon: const Icon(Icons.person),
    ),
  ),
  const SizedBox(height: 15),

  // Password
  TextField(
    controller: passwordController,
    obscureText: true,
    style: TextStyle(fontSize: textFieldFont),
    decoration: InputDecoration(
      labelText: 'Password',
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      prefixIcon: const Icon(Icons.lock),
    ),
  ),
  const SizedBox(height: 15),

  // Confirm Password
  TextField(
    controller: confirmPasswordController,
    obscureText: true,
    style: TextStyle(fontSize: textFieldFont),
    decoration: InputDecoration(
      labelText: 'Confirm Password',
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      prefixIcon: const Icon(Icons.lock_outline),
    ),
  ),

  const SizedBox(height: 30),

  // Register button
Center(
  // ignore: sized_box_for_whitespace
  child: Container(
    width: MediaQuery.of(context).size.width > 600
        ? 300  // Web view max width
        : double.infinity, // Mobile view full width
    child: ElevatedButton(
      onPressed: () {
        if (fullNameController.text.isEmpty ||
            emailController.text.isEmpty ||
            phoneController.text.isEmpty ||
            usernameController.text.isEmpty ||
            passwordController.text.isEmpty ||
            confirmPasswordController.text.isEmpty) {
          _showSnackBar("Please fill in all fields");
        } else if (passwordController.text != confirmPasswordController.text) {
          _showSnackBar("Passwords do not match");
        } else {
          register();
        }
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 14),
        backgroundColor: Colors.deepPurple,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: const Text('Register', style: TextStyle(fontSize: 16,color:Colors.white)),
    ),
  ),
),
],
            ),
          ),
        ),
      ),
    );
  }
}
