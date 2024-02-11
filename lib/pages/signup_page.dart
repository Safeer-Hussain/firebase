import 'dart:async';
import 'package:firebase/utilits/utits.dart';
import 'package:flutter/material.dart';
import '../widgets/my_button.dart';
import '../widgets/my_text_form_field.dart';
import 'login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        title: const Text("Sign up"),
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
                    icons: Icons.person,
                    emailController: nameController,
                    hintText: "Name",
                    keyboardType: TextInputType.emailAddress,
                    validatorString: "name is required",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
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
                              .createUserWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text,
                              )
                              .then((value) => print(value))
                              .onError((error, stackTrace) => print(error));
                          Utils().showToast('Account created successfully');
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            Utils().showToast('The password provided is too weak.');
                          } else if (e.code == 'email-already-in-use') {
                            Utils().showToast('The account already exists for that email.');
                          } else {
                            Utils().showToast('The email address is not valid.');
                          }
                        } catch (e) {
                          Utils().showToast(e.toString());
                        }
                      }
                    },
                    text: "Sign up",
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account?"),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    );
                  },
                  child: const Text("Log in"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
