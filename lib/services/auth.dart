import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_otp/email_otp.dart';

class AuthServiceProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  EmailOTP myauth = EmailOTP();

  Future sendOtp(String email) async {
    myauth.setConfig(
      appEmail: "me@rohitchouhan.com",
      appName: "Survey Ap",
      userEmail: email,
      otpLength: 6,
      otpType: OTPType.digitsOnly,
    );
    bool abc = await myauth.sendOTP();
    print(abc);
  }

  Future<bool> verify({required String inputOTP}) async {
    bool isVerified = await myauth.verifyOTP(otp: inputOTP);
    return Future.value(isVerified);
  }

  Future<UserCredential> addUser(String email, String password) async {
    return await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future signInWithPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      notifyListeners();
      return Future.value(true);
    } on FirebaseAuthException {
      rethrow;
    } catch (e) {
      return Future.value(e.toString());
    }
  }

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
