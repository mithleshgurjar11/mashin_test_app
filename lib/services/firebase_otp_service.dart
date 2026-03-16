import 'package:firebase_auth/firebase_auth.dart';

class FirebaseOtpService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future verifyPhone(
      String phone,
      Function(String verificationId) codeSent
      ) async {

    await _auth.verifyPhoneNumber(

      phoneNumber: "+91$phone",

      verificationCompleted: (PhoneAuthCredential credential) async {

        await _auth.signInWithCredential(credential);

      },

      verificationFailed: (FirebaseAuthException e) {

        print(e.message);

      },

      codeSent: (verificationId, resendToken) {

        codeSent(verificationId);

      },

      codeAutoRetrievalTimeout: (verificationId) {},

    );

  }

  Future verifyOtp(
      String verificationId,
      String otp
      ) async {

    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: otp,
    );

    await _auth.signInWithCredential(credential);

  }

}