import 'package:flutter/material.dart';
import 'package:tf_auth_page/tf_auth_page.dart';
import 'package:tf_responsive/tf_responsive.dart';

import '../../utils/types.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_field.dart';
import '../../resources/resources.dart' as rsc;

class SignInForm extends StatelessWidget {
  SignInForm(
      {Key? key,
      required this.authProvider,
      required this.onAuthOperationSuccess,
      required this.onAuthOperationFailed,
      required this.onCancel})
      : super(
          key: key,
        );

  final _formKey = GlobalKey<FormState>();
  final _emailTextEditingController = TextEditingController();
  final _passwordTextEditingController = TextEditingController();

  final TfAuth authProvider;

  final TfAuthOperationSuccessCallback onAuthOperationSuccess;
  final TfAuthOperationFailureCallback onAuthOperationFailed;
  final TfAuthCancelled onCancel;

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
                try {
                  final user = await authProvider.loginWithEmailPassword(
                      email: email, password: password);
                  await onAuthOperationSuccess(
                      context, TfLoginOperation(), user);
                } catch (e) {
                  await onAuthOperationFailed(context, TfLoginOperation(), e);
                }
              },
            ),
          ),
          SizedBox(height: tfHeight(2.6)),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: _buildForgotPasswordButton(context),
          ),
        ],
      ),
    );
  }

  Widget _buildForgotPasswordButton(BuildContext context) {
    return TextButton(
      onPressed: () async {
        final email = _emailTextEditingController.text;
        try {
          await authProvider.forgotPasswordForEmail(email: email);
          await onAuthOperationSuccess(context, TfLoginOperation(), null);
        } catch (e) {
          await onAuthOperationFailed(context, TfForgotPasswordOperation(), e);
        }
      },
      child: Text(
        "Forgot Password?",
        style: rsc.guiderTextStyle(context),
      ),
    );
  }
}
