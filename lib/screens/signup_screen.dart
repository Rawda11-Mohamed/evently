import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_elevated_button.dart';
import '../screens/main_screen.dart';
import '../widgets/custom_google_button.dart';
import '../widgets/custom_question_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../screens/login_screen.dart';

class SignupScreen extends StatefulWidget {
  final Function(bool) onThemeChanged;
  SignupScreen({super.key, required this.onThemeChanged});
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool isVisable1 = false;
  bool isVisable2 = false;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  Future<void> signup() async {
    if (passwordController.text != confirmPasswordController.text) {
      print('Passwords do not match');
      return;
    }
    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );
      String uid = userCredential.user!.uid;
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'name': nameController.text.trim(),
        'email': emailController.text.trim(),
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Signup successful!')));
      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (context) => MainScreen(onThemeChanged: widget.onThemeChanged),
        ),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'something went wrong')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Column(
              children: [
                SizedBox(height: 48),
                Image.asset('assets/images/Evently.png'),
                SizedBox(height: 48),
                Text(
                  'Create your account',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                CustomTextField(
                  prefixIcon: Icon(Icons.person_outline),
                  hintText: 'Enter your name',
                  isPassword: false,
                  controller: nameController,
                ),
                CustomTextField(
                  prefixIcon: Icon(Icons.email_outlined),
                  hintText: 'Enter your email',
                  isPassword: false,
                  controller: emailController,
                ),
                CustomTextField(
                  hintText: 'Enter your password',
                  prefixIcon: Icon(Icons.lock_outline),
                  isVisable: isVisable1,
                  isPassword: true,
                  onPressed: () {
                    setState(() {
                      isVisable1 = !isVisable1;
                    });
                  },
                  controller: passwordController,
                ),
                CustomTextField(
                  hintText: 'Confirm your password',
                  prefixIcon: Icon(Icons.lock_outline),
                  isVisable: isVisable2,
                  isPassword: true,
                  onPressed: () {
                    setState(() {
                      isVisable2 = !isVisable2;
                    });
                  },
                  controller: confirmPasswordController,
                ),

                SizedBox(height: 57),
                CustomElevatedButton(text: 'Signup', onPressed: signup),
                SizedBox(height: 48),
                GestureDetector(
                  child: CustomQuestionButton(
                    text: ' Login',
                    already: 'Already',
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => LoginScreen(
                              onThemeChanged: widget.onThemeChanged,
                            ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 32),
                Text(
                  'Or',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                SizedBox(height: 24),
                CustomGoogleButton(
                  text: 'Signup with Google',
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
