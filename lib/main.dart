// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:looking_for_me/components/login_page.dart';
import 'package:looking_for_me/login_auth/login_auth.dart';
import 'package:looking_for_me/login_auth/sign_up.dart';
import 'package:looking_for_me/providers/favourite_provider.dart';
import 'package:looking_for_me/screens/home_screen.dart';
import 'package:provider/provider.dart';

import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => SignupAuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => LoginAuthProvider(),
        ),
       
        ChangeNotifierProvider(
          create: (context) => FavoriteProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Testee Food',
        theme: ThemeData(
          appBarTheme: AppBarTheme(
           
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
          ),
       
          primarySwatch: Colors.blue,
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, userSnp) {
            if (userSnp.hasData) {
              return HomePage();
            }
            return LoginPage();
          },
        ),
        // home: SignupPage(),
      ),
    );
  }
}
