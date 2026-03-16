import 'package:flutter/material.dart';
import 'package:mashin_test_app/models/user_model.dart';
import 'package:mashin_test_app/services/firebase_otp_service.dart';

import '../services/auth_service.dart';


class LoginSignupProvider extends ChangeNotifier {

  final AuthService authService = AuthService();

  final FirebaseOtpService otpService = FirebaseOtpService();

  bool loading = false;

  String verificationId = "";

  Future signup(UserModel user) async {

    loading = true;
    notifyListeners();

    await authService.signup(user);

    loading = false;
    notifyListeners();

  }

  Future sendOtp(String phone) async {

    await otpService.verifyPhone(phone, (verId) {

      verificationId = verId;

    });

  }

  Future verifyOtp(String otp) async {

    await otpService.verifyOtp(verificationId, otp);

  }

  Future login(String email, String password) async {

    loading = true;
    notifyListeners();

    await authService.login(email, password);

    loading = false;
    notifyListeners();

  }

}