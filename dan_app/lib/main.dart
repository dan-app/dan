import 'package:dan_app/data/mockup_data.dart';
import 'package:dan_app/pages/base_page.dart';
import 'package:dan_app/pages/home_page.dart';
import 'package:dan_app/pages/login_page.dart';
import 'package:dan_app/pages/profile_page.dart';
import 'package:dan_app/pages/registration_page.dart';
import 'package:dan_app/pages/settings_page.dart';
import 'package:dan_app/pages/stories_page.dart';
import 'package:dan_app/pages/task_page.dart';
import 'package:dan_app/pages/theory_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
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
  String themeId = '';
  int taskNumber = -1;
  String theoryId = '';
  bool registerOpened = false;
  bool settingsOpened = false;
  final _navigatorKey = GlobalKey<NavigatorState>();

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

  void onTaskOpened({required int taskNumber, required String themeId}) {
    setState(() {
      this.taskNumber = taskNumber;
      this.themeId = themeId;
    });
  }

  void onTheoryOpened({required String theoryId}) {
    setState(
      () {
        this.theoryId = theoryId;
      },
    );
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
                  child: BasePage(
                    onSettingsPressed: onSettingsChanged,
                    pages: <Widget>[
                      HomePage(
                        data: dummyThemes,
                        taskOpenedCallback: onTaskOpened,
                        theoryOpenedCallback: onTheoryOpened,
                      ),
                      StoriesPage(),
                      ProfilePage(),
                    ],
                    items: [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.home),
                        label: 'Home',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.book),
                        label: 'Stories',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.person),
                        label: 'Profile',
                      ),
                    ],
                  ),
                ),
                if (settingsOpened)
                  MaterialPage<SettingsPage>(
                    key: ValueKey('SettingsPage'),
                    child: SettingsPage(
                      settingsPressedCallback: onSettingsChanged,
                    ),
                  ),
                if (theoryId != '')
                  MaterialPage<TheoryPage>(
                    key: ValueKey('TheoryPage'),
                    child: TheoryPage(),
                  ),
                if (taskNumber != -1)
                  MaterialPage<TaskPage>(
                    key: ValueKey('TaskPage'),
                    child: TaskPage(
                      taskDoneCallback: onTaskOpened,
                      taskNumber: taskNumber,
                      themeId: themeId,
                    ),
                  ),
              ],
            ],
            onPopPage: (route, dynamic result) {
              if (!route.didPop(result)) return false;
              if (theoryId != '') theoryId = '';
              if (taskNumber != -1) {
                taskNumber = -1;
              } else if (themeId != '') themeId = '';
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
