// Helper class for Firebase authentication operations.
import 'package:distress_app/imports.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class FirebaseAuthentication extends Object {
  late FirebaseAuth _firebaseAuth;

  factory FirebaseAuthentication() {
    return _singleton;
  }

  static final FirebaseAuthentication _singleton = FirebaseAuthentication._internal();

  FirebaseAuthentication._internal() {
    _firebaseAuth = FirebaseAuth.instance;
  }

  // Initiates phone number verification process.
  void verifyPhoneNumber({
    required String phoneNumber,
    Function(PhoneAuthCredential)? verificationCompleted,
    Function(FirebaseAuthException)? verificationFailed,
    Function(String, int?)? codeSent,
    Duration? timeout,
    Function(String)? codeAutoRetrievalTimeout,
  }) async {
    try {
      _firebaseAuth.setSettings(forceRecaptchaFlow: false);
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: verificationCompleted ?? (PhoneAuthCredential phoneAuthCredential) {},
        verificationFailed: verificationFailed ?? (FirebaseAuthException e) {},
        codeSent: codeSent ?? (String verificationId, int? resendToken) {},
        timeout: timeout ?? const Duration(seconds: 60),
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout ?? (String verificationId) {},
      );
    } catch (e) {
      rethrow;
    }
  }

  // Verifies the OTP code.
  //
  // Parameters:
  // - smsCode: The OTP code received.
  // - verificationId: The verification ID.
  Future<UserCredential?> verifyOPT({
    required String smsCode,
    required String verificationId,
  }) async {
    UserCredential? userCreds;
    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);

    try {
      await FirebaseAuth.instance.signInWithCredential(credential).then((value) {
        if (value.user != null) {
          userCreds = value;
        }
      });
    } on FirebaseException catch (e) {
      if (e.code == "invalid-verification-code") {
        Utils.showToast(
          AppLocalizations.of(Get.context!)!.verificationFailedDueToInvalidOtp,
        );
      } else if (e.code == "session-expired") {
        Utils.showToast(
          AppLocalizations.of(navState.currentContext!)!.verificationFailedDueToSessionTimeExpire,
        );
      }
    }
    return userCreds;
  }
}
