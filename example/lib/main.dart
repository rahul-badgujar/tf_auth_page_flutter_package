import 'package:example/authentication_page.dart';
import 'package:flutter/material.dart';
import 'package:tf_auth_page/tf_auth_page.dart';

import 'app.dart';

Future<void> main() async {
  // Firebase configs
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // TfAuthState must be initialized before using any functionality
  TfAuthController.instance.init(
    authProvider: TfAuthFirebase(
      firebaseAuthInstance: FirebaseAuth.instance,
    ),
  );
  // Listen to user changes
  TfAuthController.instance.userChanges.listen((user) {
    if (user == null) {
      print("User Change Listened: no-user");
    } else {
      print("User Change Listened: ${user.uid}");
    }
  });

  runApp(const MyApp());
}
