import 'package:dan_app/pages/login_page.dart';
import 'package:dan_app/pages/registration_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Navigator(
        pages: [
          MaterialPage<LoginPage>(
            key: ValueKey('LoginPage'),
            child: LoginPage(),
          ),
          if (LoginPage.goToRegister)
            MaterialPage<RegistrationPage>(
              child: RegistrationPage(),
              key: ValueKey('RegistrationPage'),
            ),
        ],
        onPopPage: (route, dynamic result) => route.didPop(result),
      ),
    );
  }
}
