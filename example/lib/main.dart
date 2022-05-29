import 'package:flutter/material.dart';
import 'package:tf_auth_page/tf_auth_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: LoginSignupScreen(
        socialLoginsRequired: const [
          SocialLoginType.google,
          SocialLoginType.facebook,
          SocialLoginType.apple,
        ],
        authProvider: TfAuthFirebase(),
        onAuthOperationSuccess: (context, operation) async {
          if (operation is TfLoginOperation) {
            showMessagedSnackbar(context, 'Logged in successfully.');
          } else if (operation is TfSignupOperation) {
            showMessagedSnackbar(context, 'Registered successfully.');
          } else if (operation is TfForgotPasswordOperation) {
            showMessagedSnackbar(context, 'Resetted password successfully.');
          }
        },
        onAuthOperationFailed: (context, operation, error) async {
          if (operation is TfLoginOperation) {
            showMessagedSnackbar(context, 'Failed to login: $error');
          } else if (operation is TfSignupOperation) {
            showMessagedSnackbar(context, 'Failed to register: $error');
          } else if (operation is TfForgotPasswordOperation) {
            showMessagedSnackbar(context, 'Failed to reset password: $error');
          }
        },
        onCancel: (context) async {
          showMessagedSnackbar(context, 'Authentication cancelled.');
        },
      ),
    );
  }

  void showMessagedSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
