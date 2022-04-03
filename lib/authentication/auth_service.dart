import 'firebase_auth_service.dart';
import '../models/user.dart';
import 'package:flutter/material.dart';

abstract class AuthService {
  FirebaseAuthService getCurrentUser();
  Stream<UserModel> get onAuthStateChanged;
  Future<UserModel> signInWithGoogle(BuildContext context);
  Future signOutUser();
  UserModel? currentUser();
  void dispose();
}
