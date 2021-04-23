import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final passwordConfirmController = TextEditingController();
  bool progressVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Пароль',
              ),
            ),
            TextField(
              controller: passwordConfirmController,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Повторите пароль',
              ),
            ),
            SizedBox(
              height: 50,
            ),
            TextButton(
              onPressed: () async {
                if (passwordConfirmController.text == passwordController.text) {
                  try {
                    var user = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                      email: emailController.text,
                      password: passwordController.text,
                    );
                    final CollectionReference users =
                        FirebaseFirestore.instance.collection('users');

                    Future<void> addUser() {
                      // Call the user's CollectionReference to add a new user
                      return users
                          .doc(user.user!.uid)
                          .set(<String, dynamic>{
                            'name': user.user!.email, // John Doe
                          })
                          .then((value) => print("User Added"))
                          .catchError((Exception error) =>
                              print("Failed to add user: $error"));
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Что-то пошло не так'),
                      ),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Пароли не совпадают!'),
                    ),
                  );
                }
              },
              child: Text("Зарегистрироватся"),
            ),
          ],
        ),
      ),
    );
  }
}
