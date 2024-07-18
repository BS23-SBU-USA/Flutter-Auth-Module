import 'package:auth_module/src/core/utils/loggers/logger.dart';
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
      rethrow;
    }
  }

  
}
