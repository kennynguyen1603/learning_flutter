import 'package:flutter/material.dart';
import 'package:learning_flutter/core/widgets/hero_widget.dart';
import 'package:learning_flutter/features/widget_tree.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../service/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthService _authService = AuthService();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool obscureText = true;
  String confirmEmail = 'testcase';
  String confirmPassword = '123';

  void handleLogin() {
    if (emailController.text == confirmEmail &&
        passwordController.text == confirmPassword) {
      // Navigate to the next page or show success message
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const WidgetTree()),
      );
    } else {
      // Show error message
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(
          const SnackBar(content: Text('Invalid email or password')));
    }
  }

  void handleObscureText() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  Future<void> handleGoogleSignIn() async {
    try {
      final UserCredential? result = await _authService.signInWithGoogle();
      if (result != null && mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const WidgetTree()),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Authentication failed: ${e.message}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('An error occurred: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login Page')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const HeroWidget(title: 'Hero Animation'),

              const SizedBox(height: 16.0),

              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  hintText: 'Enter your email',
                  prefixIcon: const Icon(Icons.email_outlined),
                ),
              ),

              const SizedBox(height: 16.0),

              TextField(
                controller: passwordController,
                obscureText: obscureText,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  hintText: 'Enter your password',
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(
                      obscureText ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: handleObscureText,
                  ),
                ),
              ),

              const SizedBox(height: 16.0),

              ElevatedButton(
                onPressed: () {
                  handleLogin();
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 60),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),

              const SizedBox(height: 16.0),

              // Add Google Sign In button
              ElevatedButton.icon(
                onPressed: handleGoogleSignIn,
                // icon: Image.asset('assets/google_logo.jpg', height: 24.0),
                label: const Text('Sign in with Google'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 60),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black87,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                    side: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
