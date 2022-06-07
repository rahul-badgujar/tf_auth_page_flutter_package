import 'package:flutter/material.dart';
import 'package:tf_auth_page/tf_auth_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: TfAuthPage(
        socialLoginsRequired: const [
          SocialLoginType.google,
          SocialLoginType.facebook,
          SocialLoginType.apple,
        ],
        authProvider:
            TfAuthFirebase(firebaseAuthInstance: FirebaseAuth.instance),
        onAuthOperationSuccess: _onAuthOperationSuccess,
        onAuthOperationFailed: _onAuthOperationFailed,
        onCancel: _onCancel,
      ),
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

  void showMessagedSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
