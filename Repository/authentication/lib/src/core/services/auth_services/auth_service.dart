import 'package:auth_module/src/core/theme/theme.dart';
import 'package:auth_module/src/core/utils/loggers/logger.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authentication {
  static Future<Map<String, dynamic>> signInWithGoogleCloud() async {
    Log.debug('came: ');

    final GoogleSignInAccount? googleAccount = await GoogleSignIn().signIn();

    Map<String, dynamic> result = {
      'errorCode': '',
      'user': googleAccount,
    };

    Log.debug('result: ');
    Log.debug(result.toString());

    Log.debug('googleAccount: ');
    Log.debug(googleAccount.toString());

    try {
      if (googleAccount != null) {
        result['errorCode'] = '';
      }
    } catch (e) {
      result['errorCode'] = 'Error occurred using Google Sign In. Try again.';
    }

    return result;
  }

  static Future<void> signOutFromGoogle() async {
    try {
      await GoogleSignIn().signOut();
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
