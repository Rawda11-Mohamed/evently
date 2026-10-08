import 'package:flutter/material.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_elevated_button.dart';
import '../core/app_colors.dart';
import '../widgets/custom_google_button.dart';
import '../widgets/custom_question_button.dart';
import '../screens/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../screens/forget_password_screen.dart';
import '../screens/main_screen.dart';

class LoginScreen extends StatefulWidget {
  final Function(bool) onThemeChanged;
  LoginScreen({super.key, required this.onThemeChanged});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isVisable = false;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser =
          await GoogleSignIn.instance.authenticate();

      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      print('Google Sign-In successful');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (context) => MainScreen(onThemeChanged: widget.onThemeChanged),
        ),
      );
    } on FirebaseAuthException catch (e) {
      print(e.code);
    }
  }

  Future<void> login() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Login successful!')));
      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (context) => MainScreen(onThemeChanged: widget.onThemeChanged),
        ),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'somthing went wrong')),
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
                  'Login to your account',
                  style: Theme.of(context).textTheme.titleLarge,
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
                  isVisable: isVisable,
                  isPassword: true,

                  controller: passwordController,

                  onPressed: () {
                    setState(() {
                      isVisable = !isVisable;
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => ForgetPasswordScreen(
                                    email: emailController.text,
                                  ),
                            ),
                          );
                        },
                        child: Text(
                          'Forget Password?',
                          style: Theme.of(context).textTheme.bodySmall!
                              .copyWith(color: AppColors.primaryLight)
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 57),
                CustomElevatedButton(text: 'Login', onPressed: login),
                SizedBox(height: 48),
                GestureDetector(
                  child: CustomQuestionButton(
                    text: ' Signup',
                    already: "Dont't",
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => SignupScreen(
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
                  text: 'Login with Google',
                  onPressed: signInWithGoogle,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
