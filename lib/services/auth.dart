import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServiceProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<UserCredential> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googlAccount = await _googleSignIn.signIn();
      final googleAuth = await googlAccount!.authentication;
      final OAuthCredential creds = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      UserCredential user =
          await FirebaseAuth.instance.signInWithCredential(creds);
      notifyListeners();
      return Future.value(user);
    } on FirebaseAuthException {
      rethrow;
    }
  }

  Future<bool> signOut() async {
    try {
      User user = FirebaseAuth.instance.currentUser!;
      if (user.providerData.first.providerId == 'google.com') {
        await _googleSignIn.disconnect();
      }
      await _auth.signOut();
      notifyListeners();
      return Future.value(true);
    } catch (e) {
      return Future.error(e);
    }
  }
}
