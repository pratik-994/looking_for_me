// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:looking_for_me/worker_login/login/components/center_part.dart';
import 'package:looking_for_me/worker_login/login/components/end_part.dart';
import 'package:looking_for_me/worker_login/login/components/login_auth_provider.dart';
import 'package:looking_for_me/worker_login/login/components/top_part.dart';
import 'package:provider/provider.dart';

class LoginPage2 extends StatefulWidget {
  const LoginPage2({Key? key}) : super(key: key);

  @override
  _LoginPageState2 createState() => _LoginPageState2();
}

class _LoginPageState2 extends State<LoginPage2> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool visible = true;
  @override
  Widget build(BuildContext context) {
    LoginAuthProvider2 loginAuthProvider =
        Provider.of<LoginAuthProvider2>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/register.png'), fit: BoxFit.cover),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // top part/
              TopPart2(),
              // center part
              CenterPart2(
                email: email,
                password: password,
                obscureText: visible,
                onPressed: () {
                  setState(() {
                    visible = !visible;
                  });
                },
                icon: Icon(
                  visible ? Icons.visibility_off : Icons.visibility,
                ),
              ),
              //end part
              EndPart2(
                loading: loginAuthProvider.loading,
                onPressed: () {
                  loginAuthProvider.loginPageVaidation(
                    emailAdress: email,
                    password: password,
                    context: context,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
