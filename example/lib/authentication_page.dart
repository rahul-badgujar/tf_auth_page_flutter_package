import 'package:flutter/material.dart';
import 'package:tf_auth_page/tf_auth_page.dart';

import 'utils.dart';

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TfAuthPage(
      appTitle: 'TfAuth App',
      appTagline: 'One place for all auth features for Tenfins',
      socialLoginsRequired: const [
        SocialLoginType.google,
        SocialLoginType.facebook,
        SocialLoginType.apple,
      ],
      onAuthOperationSuccess: _onAuthOperationSuccess,
      onAuthOperationFailed: _onAuthOperationFailed,
      onCancel: _onCancel,
    );
  }

  Future<void> _onAuthOperationSuccess(
      BuildContext context, TfAuthOperation operation, TfAuthUser? user) async {
    if (operation is TfLoginOperation) {
      showMessagedSnackbar(
          context, 'Logged in successfully (uid:${user?.email})');
    } else if (operation is TfSignupOperation) {
      showMessagedSnackbar(
          context, 'Registered successfully (uid:${user?.email})');
    } else if (operation is TfForgotPasswordOperation) {
      showMessagedSnackbar(
          context, 'Resetted password successfully (uid:${user?.email})');
    }
  }

  Future<void> _onAuthOperationFailed(
      BuildContext context, TfAuthOperation operation, dynamic error) async {
    if (operation is TfLoginOperation) {
      showMessagedSnackbar(context, 'Failed to login: $error');
    } else if (operation is TfSignupOperation) {
      showMessagedSnackbar(context, 'Failed to register: $error');
    } else if (operation is TfForgotPasswordOperation) {
      showMessagedSnackbar(context, 'Failed to reset password: $error');
    }
  }

  Future<void> _onCancel(BuildContext context) async {
    showMessagedSnackbar(context, 'Authentication cancelled.');
  }
}
