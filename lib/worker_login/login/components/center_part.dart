// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:looking_for_me/route_page/routing_page.dart';
import 'package:looking_for_me/worker_login/login/forgotPassword/forgot_password.dart';


class CenterPart2 extends StatelessWidget {
  final TextEditingController? email;
  final bool obscureText;
  final TextEditingController? password;
  final Widget icon;
  final void Function()? onPressed;
  CenterPart2({
    required this.obscureText,
    required this.icon,
    required this.email,
    required this.password,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: email,
          decoration: InputDecoration(
            hintText: "Email",
          ),
        ),
        TextFormField(
          obscureText: obscureText,
          controller: password,
          decoration: InputDecoration(
            counter: GestureDetector(
              onTap: () {
                RoutingPage.goTonext(
                  context: context,
                  navigateTo: ForgotPassword2(),
                );
              },
              child: Text(
                "Forgot Password?",
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
            ),
            hintText: "Password",
            suffixIcon: IconButton(onPressed: onPressed, icon: icon),
          ),
        ),
      ],
    );
  }
}
