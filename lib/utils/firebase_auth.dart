import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  var isLoading = false.obs;

  // ✅ Email sign-in
  Future<void> signIn(String email, String password) async {
    try {
      isLoading(true);
      await auth.signInWithEmailAndPassword(email: email, password: password);
      goToHome();
    } catch (e) {
      Get.snackbar('Login Failed', "Invalid email or password. Please try again.",backgroundColor: Colors.red.shade50);
    } finally {
      isLoading(false);
    }
  }

  // ✅ Email sign-up
  Future<void> signUp(String email, String password) async {
    try {
      isLoading(true);
      await auth.createUserWithEmailAndPassword(email: email, password: password);
      goToHome();
    } catch (e) {
      Get.snackbar('Sign Up Failed', e.toString());
    } finally {
      isLoading(false);
    }
  }

  // ✅ Google Sign-In (for google_sign_in ^6.2.1)
  Future<void> signInWithGoogle() async {
    try {
      isLoading(true);

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        isLoading(false);
        return; // User cancelled
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await auth.signInWithCredential(credential);
      goToHome();
    } catch (e) {
      Get.snackbar('Google Sign-In Failed', e.toString());
    } finally {
      isLoading(false);
    }
  }

  void goToHome() {
    Get.offAllNamed('/commonScreen');
  }
}
