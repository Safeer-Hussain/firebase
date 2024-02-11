import 'package:firebase/utilits/utits.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widgets/my_button.dart';
import '../widgets/my_text_form_field.dart';
import 'home_page.dart';
import 'signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        SystemNavigator.pop();
      },
      canPop: false,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.blue,
            title: const Text("Login"),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      MyTextFormField(
                        icons: Icons.email,
                        emailController: emailController,
                        hintText: "Email",
                        keyboardType: TextInputType.emailAddress,
                        validatorString: "Email is required",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      MyTextFormField(
                        icons: Icons.lock,
                        emailController: passwordController,
                        hintText: "Password",
                        keyboardType: TextInputType.visiblePassword,
                        validatorString: "Password is required",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      MyButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            try {
                              await _auth
                                  .signInWithEmailAndPassword(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  )
                                  .then(
                                    (value) => Navigator.push(context, MaterialPageRoute(builder: (context) => const MyHomePage())),
                                  );
                            } on FirebaseAuthException catch (e) {
                              Utils().showToast(e.message);
                            }
                          }
                        },
                        text: "Log in",
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignupPage(),
                            ),
                          );
                        }
                      },
                      child: const Text("Sign up"),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
