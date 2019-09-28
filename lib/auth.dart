import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuth {
  Future<AuthResult> signInWithEmailAndPassword(String email, String senha);
  Future<AuthResult> createUserWithEmailAndPassword(String email, String senha);
}

class Auth implements BaseAuth{

  Future<AuthResult> signInWithEmailAndPassword(String email, String senha) async {
    AuthResult user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: senha);

    return user;
  }

  Future<AuthResult> createUserWithEmailAndPassword(String email, String senha) async {
    AuthResult user = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: senha);

    return user;
  }
}