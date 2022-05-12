import 'package:app1/models/models.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  createAccount({required String email, required String password}) async {
    http.Client client = http.Client();
    final FirebaseAuth auth = FirebaseAuth.instance;
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final User user = auth.currentUser!;
      final uid = user.uid;
      var res = await client.post(
        Uri.http(serverUri, '/register-user'),
        body: {'uid': uid},
      );

      // ignore: unnecessary_null_comparison
      if (res == null) {
        debugPrint('Server error!');
      }

      return 'Account created';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email';
      } else if (e.code == 'invalid-email') {
        return 'Invalid email address. Please check again';
      } else if (e.code == 'invalid-password') {
        return 'The password should be at least 6 characters long';
      }
    } catch (e) {
      debugPrint('error occurred');
      return 'Error occurred!';
    } finally {
      client.close();
    }
  }

  signIn({required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return 'welcome';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user';
      } else if (e.code == 'invalid-email') {
        return 'Invalid email address. Please check again';
      } else if (e.code == 'invalid-password') {
        return 'The password should be at least 6 characters long';
      }
    } catch (e) {
      return 'Error occurred!';
    }
  }

  resetPassword({String? email}) async {
    try {
      _auth.sendPasswordResetEmail(email: email!);
      return 'email sent';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        return 'Invalid email address';
      } else if (e.code == 'user-not-found') {
        return 'No user found for that email';
      }
    } catch (e) {
      return 'error occurred';
    }
  }

  void logout() async {
    http.Client client = http.Client();
    final User user = _auth.currentUser!;
    final uid = user.uid;
    try {
      await _auth.signOut();
      await client.post(
        Uri.http(serverUri, '/logout'),
        body: {'uid': uid},
      );
      debugPrint('logged out');
    } catch (e) {
      debugPrint('Error logging you out');
    } finally {
      client.close();
    }
  }
}
