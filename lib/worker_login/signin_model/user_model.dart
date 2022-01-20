import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel2 {
  final String fullName;
  final String emailAddress;
  final String password;
  final String userUid;
  UserModel2({
    required this.fullName,
    required this.emailAddress,
    required this.password,
    required this.userUid,
  });

  factory UserModel2.fromDocument(DocumentSnapshot doc) {
    return UserModel2(
      fullName: doc['fullName'],
      emailAddress: doc['emailAdress'],
      password: doc['password'],
      userUid: doc['userUid'],
    );
  }
}
