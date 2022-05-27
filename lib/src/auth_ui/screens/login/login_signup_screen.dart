import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tf_auth_firebase/tf_auth_firebase.dart';
import 'package:tf_auth_page/src/auth_ui/utils/types.dart';
import 'package:tf_responsive/tf_responsive.dart';

import '../../resources/colors.dart';
import '../../utils/ui_utils.dart';
import '../../widgets/app_logo.dart';
import 'signin_form.dart';
import 'signup_form.dart';

class LoginSignupScreen extends StatelessWidget {
  const LoginSignupScreen({
    Key? key,
    required this.authProvider,
    required this.onAuthOperationFailed,
    required this.onAuthOperationSuccess,
    required this.onCancel,
  }) : super(key: key);

  final TfAuth authProvider;

  final TfAuthOperationSuccessCallback onAuthOperationSuccess;
  final TfAuthOperationFailureCallback onAuthOperationFailed;
  final TfAuthCancelled onCancel;

  @override
  Widget build(BuildContext context) {
    return TfResponsiveBuilder(
      builder: ((context, deviceType, deviceOrientation) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: ColorPalette.primaryColor,
            body: SafeArea(
              child: SizedBox(
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: tfWidth(4)),
                    child: Column(
                      children: [
                        SizedBox(height: tfHeight(5)),
                        const AppLogo(),
                        SizedBox(height: tfHeight(5)),
                        _buildAuthTabsContent(context),
                        _buildSocialLoginPanel(context),
                        SizedBox(height: tfHeight(5)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildAuthTabsContent(BuildContext context) {
    return Column(
      children: [
        _buildTabTitles(context),
        SizedBox(height: tfHeight(4.2)),
        _buildTabItems(context),
      ],
    );
  }

  Widget _buildTabTitles(BuildContext context) {
    // Builder to build Tab Title Item
    Widget _tabTitleItemBuilder(String lableText) => Tab(
          child: Text(
            "     $lableText     ",
            style: TextStyle(
              fontSize: tfText(2.8),
            ),
          ),
        );

    return TabBar(
      indicatorSize: TabBarIndicatorSize.label,
      tabs: [
        _tabTitleItemBuilder(
          "Sign In",
        ),
        _tabTitleItemBuilder(
          "Sign Up",
        ),
      ],
    );
  }

  Widget _buildTabItems(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: tfHeight(40)),
      child: TabBarView(children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: tfWidth(5)),
          child: SignInForm(
            authProvider: authProvider,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: tfWidth(5)),
          child: SignUpForm(
            authProvider: authProvider,
          ),
        ),
      ]),
    );
  }

  Widget _buildSocialLoginPanel(BuildContext context) {
    return Column(
      children: [
        Text(
          "Or use a social account to login",
          style: TextStyle(
            color: ColorPalette.textColorBrightDimmed,
            fontSize: tfText(2),
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: tfHeight(2)),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSocialLoginButton(
                iconAssetPath: 'assets/images/fb_logo.png',
                onPressed: () async {
                  try {
                    await authProvider.loginWithFacebook();
                  } catch (e) {
                    // handling errors here
                    showMessagedSnackbar(context, e.toString());
                  }
                },
              ),
              _buildSocialLoginButton(
                iconAssetPath: 'assets/images/google_logo.png',
                onPressed: () async {
                  try {
                    await authProvider.loginWithGoogle();
                  } catch (e) {
                    // handling errors here
                    showMessagedSnackbar(context, e.toString());
                  }
                },
              ),
              _buildSocialLoginButton(
                iconAssetPath: 'assets/images/apple_logo.png',
                onPressed: () async {
                  try {
                    await authProvider.loginWithApple();
                  } catch (e) {
                    // handling errors here
                    showMessagedSnackbar(context, e.toString());
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSocialLoginButton(
      {required String iconAssetPath, required VoidCallback onPressed}) {
    return Padding(
      padding: EdgeInsets.all(tfImage(4)),
      child: GestureDetector(
        onTap: onPressed,
        child: CircleAvatar(
          backgroundColor: Colors.black,
          radius: tfImage(6.5),
          child: Padding(
            padding: EdgeInsets.all(tfImage(3.4)),
            child: Image.asset(
              iconAssetPath,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
