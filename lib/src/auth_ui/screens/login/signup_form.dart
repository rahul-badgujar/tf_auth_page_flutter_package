import 'package:flutter/material.dart';
import 'package:tf_auth_page/tf_auth_page.dart';
import 'package:tf_responsive/tf_responsive.dart';

import '../../utils/types.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_field.dart';

class SignUpForm extends StatelessWidget {
  SignUpForm(
      {Key? key,
      required this.onAuthOperationSuccess,
      required this.onAuthOperationFailed,
      required this.onCancel})
      : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final _emailTextEditingController = TextEditingController();
  final _passwordTextEditingController = TextEditingController();
  final _confirmPasswordTextEditingController = TextEditingController();

  final TfAuthOperationSuccessCallback onAuthOperationSuccess;
  final TfAuthOperationFailureCallback onAuthOperationFailed;
  final TfAuthCancelledCallback onCancel;

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
          SizedBox(height: tfHeight(2.6)),
          Flexible(
            child: CustomTextField(
              controller: _confirmPasswordTextEditingController,
              hintText: "Confirm Password",
              obsecureText: true,
            ),
          ),
          SizedBox(height: tfHeight(3.3)),
          Flexible(
            child: CustomElevatedButton(
              lable: "Register",
              onPressed: () async {
                final email = _emailTextEditingController.text.trim();
                final password = _passwordTextEditingController.text.trim();
                final confirmedPassword =
                    _confirmPasswordTextEditingController.text.trim();

                try {
                  if (password != confirmedPassword) {
                    throw Exception('Password and Confirm Password must match');
                  }
                  final user = await TfAuthController.instance.authProvider
                      .signupWithEmailPassword(
                          email: email, password: password);
                  TfAuthController.instance.currentUser = user;
                  await onAuthOperationSuccess(
                      context, TfSignupOperation(), user);
                } catch (e) {
                  // TfAuthController.instance.currentUser = null;
                  await onAuthOperationFailed(context, TfSignupOperation(), e);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
