import 'package:flutter/material.dart';
import '../widgets/custom_elevated_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgetPasswordScreen extends StatefulWidget {
  final String email;
  ForgetPasswordScreen({super.key, required this.email});
  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  Future<void> resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: widget.email.trim(),
      );
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Password reset email sent')));
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'sonething went wrong')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          title: Text('Forget Password'),
        ),

        body: Column(
          children: [
            SizedBox(height: 32),
            Image.asset('assets/images/change-setting.png'),
            SizedBox(height: 40),

            CustomElevatedButton(
              text: 'Reset Password',
              onPressed: resetPassword,
            ),
          ],
        ),
      ),
    );
  }
}
