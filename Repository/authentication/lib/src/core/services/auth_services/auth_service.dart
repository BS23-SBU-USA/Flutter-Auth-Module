import 'package:auth_module/src/core/theme/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authentication {
  static Future<Map<String, dynamic>> signInWithGoogle(
      {required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    Map<String, dynamic> result = {
      'errorCode': '',
      'user': user,
    };

    final GoogleSignInAccount? googleAccount = await GoogleSignIn().signIn();

    if (googleAccount != null) {
      final GoogleSignInAuthentication authentication =
          await googleAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: authentication.accessToken,
        idToken: authentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);

        result['user'] = userCredential.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          result['errorCode'] =
              'The account already exists with a different credential';
        } else if (e.code == 'invalid-credential') {
          result['errorCode'] =
              'Error occurred while accessing credentials. Try again.';
        }
      } catch (e) {
        result['errorCode'] = 'Error occurred using Google Sign In. Try again.';
      }
    } else {
      result['errorCode'] = 'Sign-in canceled by the user.';
    }

    return result;
  }

  static Future<void> signOutFromGoogle({
    required BuildContext context,
  }) async {
    try {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      snackBar(
        content: 'Error signing out. Try again.',
      );
    }
  }

  static SnackBar snackBar({required String content}) {
    return SnackBar(
      duration: const Duration(seconds: 3),
      content: Center(
        child: Text(
          content,
          style: const TextStyle(color: UIColors.white, fontSize: 16),
        ),
      ),
      backgroundColor: UIColors.red,
    );
  }
}
