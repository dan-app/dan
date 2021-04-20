import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegistrationPage extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
            ),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Пароль',
              ),
            ),
            TextField(
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
                    UserCredential userCredential = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text);
                  } catch (e) {
                    print(e);
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Пароли не совпадают!')));
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
