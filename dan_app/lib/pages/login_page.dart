import 'package:dan_app/utils/images.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final Function registerChangedCallback;

  const LoginPage({required this.registerChangedCallback});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  bool progressVisible = false;
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(CustomImages.logoTitle),
              TextField(
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Login',
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
              SizedBox(
                height: 50,
              ),
              TextButton(
                onPressed: () async {
                  if (emailController.text != '' &&
                      passwordController.text != '') {
                    setState(() {
                      progressVisible = true;
                    });
                    try {
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text,
                      );
                    } on FirebaseAuthException {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              Text('Проверьте корректность введённых данных'),
                        ),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Something went wrong'),
                        ),
                      );
                    } finally {
                      setState(() {
                        progressVisible = false;
                      });
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Не все поля заполнены!'),
                      ),
                    );
                  }
                },
                child: Text("Sign in"),
              ),
              TextButton(
                onPressed: () {
                  widget.registerChangedCallback();
                },
                child: Text("Sign up"),
              ),
              if (progressVisible) CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
