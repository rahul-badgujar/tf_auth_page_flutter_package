import 'package:flutter/material.dart';
import 'package:tf_auth_page/src/auth_ui/utils/ui_utils.dart';
import 'package:tf_auth_page/tf_auth_page.dart';
import 'package:tf_responsive/tf_responsive.dart';

import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_field.dart';

class SignInForm extends StatelessWidget {
  SignInForm({Key? key, required this.authProvider})
      : super(
          key: key,
        );

  final _formKey = GlobalKey<FormState>();
  final _emailTextEditingController = TextEditingController();
  final _passwordTextEditingController = TextEditingController();

  final TfAuth authProvider;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Flexible(
            child: CustomTextField(
              controller: _emailTextEditingController,
              hintText: "Email Address",
            ),
          ),
          SizedBox(height: tfHeight(2.6)),
          Flexible(
            child: CustomTextField(
              controller: _passwordTextEditingController,
              hintText: "Password",
              obsecureText: true,
            ),
          ),
          SizedBox(height: tfHeight(3.3)),
          Flexible(
            child: CustomElevatedButton(
              lable: "Login",
              onPressed: () async {
                final email = _emailTextEditingController.text;
                final password = _passwordTextEditingController.text;
                print("Email: $email Password: $password");
                try {
                  await authProvider.loginWithEmailPassword(
                      email: email, password: password);
                } catch (e) {
                  // handling errors here
                  showMessagedSnackbar(context, e.toString());
                }
              },
            ),
          ),
          SizedBox(height: tfHeight(2.6)),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: _buildForgotPasswordButton(),
          ),
        ],
      ),
    );
  }

  Widget _buildForgotPasswordButton() {
    return TextButton(
      onPressed: () {},
      child: Text(
        "Forgot Password?",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: tfText(2.2),
        ),
      ),
    );
  }
}
