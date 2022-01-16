

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class FavoriteProvider with ChangeNotifier {
  void favorite({
 
    required id,
    required job,
    required location,
    required name,
    required phoneNo,
    required picture,
  }) {
    FirebaseFirestore.instance
        .collection("favorite")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("userFavorite")
        .doc(id)
        .set(
      {
       
        "id": id,
        "job": job,
        "location": location,
        "name": name,
        "picture": picture
      },
    );
  }

  deleteFavorite({required String productId}) {
    FirebaseFirestore.instance
        .collection("favorite")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("userFavorite")
        .doc(productId)
        .delete();
    notifyListeners();
  }
}
