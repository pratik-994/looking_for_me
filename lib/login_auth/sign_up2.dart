// // ignore_for_file: prefer_const_constructors

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_login_signup/src/login-reg/regSelect.dart';

// class SignupAuthProvider2 with ChangeNotifier {
//   static Pattern pattern =
//       r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

//   RegExp regExp = RegExp(SignupAuthProvider2.pattern.toString());
//   UserCredential? userCredential;

//   bool loading = false;

//   void signupVaidation2(
//       {required TextEditingController? fullName,
//       required TextEditingController? emailAdress,
//       required TextEditingController? password,
      
//        required TextEditingController? userAddress,

//       required BuildContext context}) async {
//     if (fullName!.text.trim().isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text("Full name is empty"),
//         ),
//       );
//          if (fullName!.text.trim().isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text("User address is empty"),
//         ),
//       );
//       return;
//     } else if (emailAdress!.text.trim().isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text("Email address is empty"),
//         ),
//       );
//       return;
//     } else if (!regExp.hasMatch(emailAdress.text.trim())) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text("Invalid email address"),
//         ),
//       );
//       return;
//     } else if (password!.text.trim().isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text("Password is empty"),
//         ),
//       );
//       return;
//     } else if (password.text.length < 8) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text("Password must be 8"),
//         ),
//       );
//       return;
//     } else {
//       try {
//         loading = true;
//         notifyListeners();
//         userCredential =
//             await FirebaseAuth.instance.createUserWithEmailAndPassword(
//           email: emailAdress.text,
//           password: password.text,
//         );
//         loading = true;
//         notifyListeners();

//         FirebaseFirestore.instance
//             .collection("Worker users")
//             .doc(userCredential!.user!.uid)
//             .set(
//           {
//             "fullName": fullName.text,
//             "userAddress" : userAddress!.text,
//             "emailAdress": emailAdress.text,
//             "password": password.text,
//             "userUid": userCredential!.user!.uid,
//           },
//         ).then((value) {
//           loading = false;
//           notifyListeners();
//            Navigator.push(
//             context, MaterialPageRoute(builder: (context) => regSelect()));
//         Navigator.push(
//             context, MaterialPageRoute(builder: (context) => regSelect()));
//           // );
//         });
//       } on FirebaseAuthException catch (e) {
//         loading = false;
//         notifyListeners();
//         if (e.code == "weak-password") {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text("weak-password"),
//             ),
//           );
//         } else if (e.code == 'email-already-in-use') {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text("email-already-in-use"),
//             ),
//           );
//         }
//       }
//     }
//   }
// }
// }
