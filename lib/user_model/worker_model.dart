import 'package:cloud_firestore/cloud_firestore.dart';

class UserMode2 {
  final String fullName;
  final String emailAddress;
  final String password;
  final String userUid;
  final String userAddress;
  UserMode2({
    required this.fullName,
    required this.emailAddress,
    required this.password,
    required this.userUid,
    required this.userAddress
  });

  factory UserMode2.fromDocument(DocumentSnapshot doc) {
    return UserMode2(
      fullName: doc['fullName'],
      emailAddress: doc['emailAdress'],
      password: doc['password'],
      userUid: doc['userUid'],
      userAddress: doc['userAddress']
    );
  }
}
