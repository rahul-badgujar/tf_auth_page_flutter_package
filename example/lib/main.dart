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
        authProvider: TfAuthFirebase(),
        onAuthOperationSuccess: (context, operation) async {
          if (operation is TfLoginOperation) {}
        },
        onAuthOperationFailed: (context, operation) async {},
        onCancel: (context) async {},
      ),
    );
  }
}
