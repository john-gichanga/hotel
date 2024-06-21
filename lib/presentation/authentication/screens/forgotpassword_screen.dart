import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Enter your email and we will send you a password reset link.',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.sendPasswordResetEmail(
                  email: _emailController.text.trim(),
                );
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Password Reset Email Sent'),
                    content:
                        Text('Check your email for a link to reset your password.'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text('OK'),
                      ),
                    ],
                  ),
                );
              },
              child: Text('Send Password Reset Email'),
            ),
          ],
        ),
     ),
 );
 }
}