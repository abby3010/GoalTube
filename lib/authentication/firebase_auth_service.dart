import '../models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'auth_service.dart';

class FirebaseAuthService implements AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final CollectionReference users =
      FirebaseFirestore.instance.collection('Users');

  // UserModel is a custom Class which we made in user.dart
  // User is a firebase Auth class which comes inbuilt with firebase_auth package.
  UserModel _userFromFirebase(User? user) {
    return UserModel(
      uid: user!.uid,
      email: user.email,
      displayName: user.displayName,
      photoUrl: user.photoURL,
    );
  }

  @override
  FirebaseAuthService getCurrentUser() {
    return this;
  }

  @override
  UserModel? currentUser() {
    final User? user = _firebaseAuth.currentUser;
    if (user != null) {
      return _userFromFirebase(user);
    } else {
      return null;
    }
  }

  @override
  Stream<UserModel> get onAuthStateChanged {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  @override
  Future<UserModel> signInWithGoogle(BuildContext context) async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final authResult = await _firebaseAuth.signInWithCredential(credential);
    final user = authResult.user;
    // add the users document if not ready
    users.doc(user!.email).get().then(
      (DocumentSnapshot documentSnapshot) async {
        if (!documentSnapshot.exists) {
          await createFirebaseDocument(user);
          Navigator.pushNamed(context, "/home");
        } else {
          Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false);
          Fluttertoast.showToast(msg: "Sign in successful!");
        }
      },
    );

    return _userFromFirebase(user);
  }

  @override
  Future signOutUser() async {
    return _firebaseAuth.signOut();
  }

  Future<void> createFirebaseDocument(User user) {
    return users.doc(user.email).set({
      "name": user.displayName,
      "email": user.email,
      "photoUrl": user.photoURL,
      "uid": user.uid,
      "phone": user.phoneNumber,
      "courses": []
    }).catchError((error) {
      if (kDebugMode) {
        print("Failed to add user: $error");
      }
    });
  }

  @override
  void dispose() {}
}
