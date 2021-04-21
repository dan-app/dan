import 'package:dan_app/pages/base_page.dart';
import 'package:dan_app/pages/login_page.dart';
import 'package:dan_app/pages/registration_page.dart';
import 'package:dan_app/pages/settings_page.dart';
import 'package:dan_app/pages/task_page.dart';
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
  bool settingsOpened = false;
  final _navigatorKey = GlobalKey<NavigatorState>();
  int themeNumber = 0;
  int taskNumber = 0;

  void onRegisterChanged() {
    setState(() {
      registerOpened = !registerOpened;
    });
  }

  void onSettingsChanged() {
    setState(() {
      settingsOpened = !settingsOpened;
    });
  }

  void onTaskOpened({required int taskNumber, required int themeNumber}) {
    setState(() {
      settingsOpened = !settingsOpened;
    });
  }

  void onTheoryOpened() {
    setState(() {
      settingsOpened = !settingsOpened;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => !await _navigatorKey.currentState!.maybePop(),
      child: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          return Navigator(
            key: _navigatorKey,
            pages: [
              if (snapshot.data == null) ...[
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
              ] else ...[
                MaterialPage<BasePage>(
                  key: ValueKey('BasePage'),
                  child: BasePage(onSettingsPressed: onSettingsChanged),
                ),
                if (settingsOpened)
                  MaterialPage<SettingsPage>(
                    key: ValueKey('SettingsPage'),
                    child: SettingsPage(
                      settingsPressedCallback: onSettingsChanged,
                    ),
                  ),
                if (themeNumber != 0)
                  MaterialPage<TaskPage>(
                    key: ValueKey('TaskPage'),
                    child: TaskPage(
                      taskNumber: taskNumber,
                    ),
                  ),
              ],
            ],
            onPopPage: (route, dynamic result) {
              if (!route.didPop(result)) return false;
              if (settingsOpened) {
                setState(() {
                  settingsOpened = !settingsOpened;
                });
              }
              return true;
            },
          );
        },
      ),
    );
  }
}
