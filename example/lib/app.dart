import 'package:example/home_page.dart';
import 'package:flutter/material.dart';
import 'package:tf_auth_page/tf_auth_page.dart';

import 'authentication_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: StreamBuilder<TfAuthUser?>(
        stream: TfAuthController.instance.userChanges,
        builder: (context, snapshot) {
          final user = snapshot.data;
          if (user == null) {
            return const AuthenticationPage();
          } else {
            return const HomePage();
          }
        },
      ),
    );
  }
}
