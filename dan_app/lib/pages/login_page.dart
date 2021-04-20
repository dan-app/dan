import 'package:dan_app/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  static bool goToRegister = false;
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
                labelText: 'Логин',
              ),
            ),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Пароль',
              ),
            ),
            SizedBox(
              height: 50,
            ),
            TextButton(
              onPressed: () {
                FirebaseAuth auth = FirebaseAuth.instance;
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute<HomePage>(builder: (context) => HomePage()),
                );
              },
              child: Text("Войти"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute<HomePage>(builder: (context) => HomePage()),
                );
              },
              child: Text("Зарегистрироватся"),
            ),
          ],
        ),
      ),
    );
  }
}
