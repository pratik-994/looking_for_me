// ignore_for_file: prefer_const_constructors


import 'package:flutter/material.dart';
import 'package:looking_for_me/route_page/routing_page.dart';
import 'package:looking_for_me/worker_login/login/signup/signup_page.dart';
import 'package:looking_for_me/worker_login/login/widgets/my_button.dart';


class EndPart2 extends StatelessWidget {
  final void Function()? onPressed;
  final bool loading;
  const EndPart2({
    required this.loading,
    required this.onPressed,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        loading == true
            ? CircularProgressIndicator()
            : MyButton(
                onPressed: onPressed,
                text: "LOG IN",
              ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Don't have an account?\t\t"),
            GestureDetector(
              onTap: () {
                RoutingPage.goTonext(
                  context: context,
                  navigateTo: SignupPage(),
                );
              },
              child: Text("SIGN UP"),
            ),
          ],
        )
      ],
    );
  }
}
