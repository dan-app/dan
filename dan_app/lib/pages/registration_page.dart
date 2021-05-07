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

  void initUser() {
    ['basics', 'family', 'places'].forEach((element) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('themes')
          .doc(element)
          .set(<String, int>{'tasks_done': 0})
          .then((value) {})
          .catchError(
            (dynamic error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Something went wrong'),
                ),
              );
            },
          );
    });
  }

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
                labelText: 'Password',
              ),
            ),
            TextField(
              controller: passwordConfirmController,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password confirmation',
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
                          .catchError((Object error) =>
                              print("Failed to add user: $error"));
                    }

                    addUser();
                    initUser();
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Something went wrong'),
                      ),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Passwords are not the same!'),
                    ),
                  );
                }
              },
              child: Text("Register"),
            ),
          ],
        ),
      ),
    );
  }
}
