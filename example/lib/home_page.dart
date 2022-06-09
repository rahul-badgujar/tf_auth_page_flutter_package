import 'package:flutter/material.dart';
import 'package:tf_auth_page/tf_auth_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home Page")),
      body: Center(
        child: Column(
          children: [
            const Spacer(),
            Text(
                "Logged in with UID: ${TfAuthController.instance.currentUser?.uid}"),
            ElevatedButton(
              child: const Text("Logout"),
              onPressed: () async {
                await TfAuthController.instance.logout();
              },
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
