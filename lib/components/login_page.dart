import 'package:flutter/material.dart';
import 'package:looking_for_me/components/end_part.dart';
import 'package:looking_for_me/components/top_part.dart';
import 'package:looking_for_me/login_auth/login_auth.dart';

import 'package:provider/provider.dart';

import 'center_part.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool visible = true;
  @override
  Widget build(BuildContext context) {
    LoginAuthProvider loginAuthProvider =
        Provider.of<LoginAuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // top part/
              const TopPart(),
              // center part
              CenterPart(
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
              EndPart(
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
