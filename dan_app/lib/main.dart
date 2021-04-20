import 'package:dan_app/pages/home_page.dart';
import 'package:dan_app/pages/login_page.dart';
import 'package:dan_app/pages/registration_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool registerOpened = false;

  void onRegisterChanged() {
    setState(() {
      registerOpened = !registerOpened;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      pages: [
        if (FirebaseAuth.instance.currentUser == null)
          MaterialPage<LoginPage>(
            key: ValueKey('LoginPage'),
            child: LoginPage(
              registerChangedCallback: onRegisterChanged,
            ),
          ),
        if (registerOpened)
          MaterialPage<RegistrationPage>(
            child: RegistrationPage(),
            key: ValueKey('RegistrationPage'),
          ),
        MaterialPage<HomePage>(
          key: ValueKey('HomePage'),
          child: HomePage(),
        ),
      ],
      onPopPage: (route, dynamic result) => route.didPop(result),
    );
  }
}
