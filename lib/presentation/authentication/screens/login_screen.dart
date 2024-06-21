import 'package:flutter/material.dart';
import 'package:hotel/presentation/authentication/widgets/logo.dart';
import 'package:hotel/presentation/home/widgets/bottom_nav.dart';
import 'package:provider/provider.dart';
import 'package:hotel/providers/auth_provider.dart';
import 'forgotpassword_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const LogoWidget(),
            const SizedBox(height: 24),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                String email = _emailController.text.trim();
                String password = _passwordController.text.trim();
                // Pass the current context to the AuthProvider
                await context
                    .read<AuthProvider>()
                    .signInWithEmailAndPassword(context, email, password);
                // Check if the user is created successfully
                if (context.read<AuthProvider>().user != null) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) =>  BottomBar()),
                  );
                }
              },
              child: const Text('Login'),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>  ForgotPasswordPage()),
                );
              },
              child: const Text('Forgot Password?'),
              style: TextButton.styleFrom(
                foregroundColor: Colors.blue,
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/admin');
              },
              child: const Text('Login as admin'),
              style: TextButton.styleFrom(
                foregroundColor: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
