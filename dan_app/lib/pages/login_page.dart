import 'package:dan_app/pages/base_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final Function registerChangedCallback;

  const LoginPage({required this.registerChangedCallback});

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
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute<BasePage>(builder: (context) => BasePage()),
                );
              },
              child: Text("Войти"),
            ),
            TextButton(
              onPressed: () {
                registerChangedCallback();
              },
              child: Text("Зарегистрироватся"),
            ),
          ],
        ),
      ),
    );
  }
}
