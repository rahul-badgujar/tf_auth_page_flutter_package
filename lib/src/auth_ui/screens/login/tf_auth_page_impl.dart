import 'package:flutter/material.dart';
import 'package:tf_auth_page/src/auth_ui/utils/types.dart';
import 'package:tf_responsive/tf_responsive.dart';

import '../../../../tf_auth_page.dart';
import '../../widgets/app_logo.dart';
import 'signin_form.dart';
import 'signup_form.dart';
import '../../resources/resources.dart' as rsc;

class TfAuthPage extends StatelessWidget {
  const TfAuthPage({
    Key? key,
    required this.onAuthOperationFailed,
    required this.onAuthOperationSuccess,
    required this.onCancel,
    this.socialLoginsRequired = const <SocialLoginType>[],
  }) : super(key: key);

  // Auth result callbacks
  final TfAuthOperationSuccessCallback onAuthOperationSuccess;
  final TfAuthOperationFailureCallback onAuthOperationFailed;
  final TfAuthCancelledCallback onCancel;

  // Social Login options
  final List<SocialLoginType> socialLoginsRequired;

  @override
  Widget build(BuildContext context) {
    return TfResponsiveBuilder(
      builder: ((context, deviceType, deviceOrientation) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            // backgroundColor: Theme.of(context).backgroundColor,
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
                        if (socialLoginsRequired.isNotEmpty)
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
            style: rsc.tabTitleTextStyle(context),
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
            onAuthOperationSuccess: onAuthOperationSuccess,
            onAuthOperationFailed: onAuthOperationFailed,
            onCancel: onCancel,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: tfWidth(5)),
          child: SignUpForm(
            onAuthOperationSuccess: onAuthOperationSuccess,
            onAuthOperationFailed: onAuthOperationFailed,
            onCancel: onCancel,
          ),
        ),
      ]),
    );
  }

  Widget _buildSocialLoginPanel(BuildContext context) {
    final listOfSocialAuthButtons = <Widget>[];
    for (final socialLoginType in socialLoginsRequired) {
      listOfSocialAuthButtons
          .add(_socialAuthButtonFromType(context, socialLoginType));
    }
    return Column(
      children: [
        Text(
          "Or use a social account to login",
          style: rsc.guiderTextStyle(context)?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        SizedBox(height: tfHeight(2)),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: listOfSocialAuthButtons,
        ),
      ],
    );
  }

  Widget _socialAuthButtonFromType(BuildContext context, SocialLoginType type) {
    if (type == SocialLoginType.facebook) {
      return _buildSocialLoginButton(
        context: context,
        iconAssetPath: 'assets/images/fb_logo.png',
        onPressed: () async {
          try {
            final user = await TfAuthController.instance.authProvider
                .loginWithFacebook();
            await onAuthOperationSuccess(context, TfLoginOperation(), user);
          } catch (e) {
            await onAuthOperationFailed(context, TfLoginOperation(), e);
          }
        },
      );
    } else if (type == SocialLoginType.google) {
      return _buildSocialLoginButton(
        context: context,
        iconAssetPath: 'assets/images/google_logo.png',
        onPressed: () async {
          try {
            final user =
                await TfAuthController.instance.authProvider.loginWithGoogle();
            await onAuthOperationSuccess(context, TfLoginOperation(), user);
          } catch (e) {
            await onAuthOperationFailed(context, TfLoginOperation(), e);
          }
        },
      );
    } else if (type == SocialLoginType.apple) {
      return _buildSocialLoginButton(
        context: context,
        iconAssetPath: 'assets/images/apple_logo.png',
        onPressed: () async {
          try {
            final user =
                await TfAuthController.instance.authProvider.loginWithApple();
            await onAuthOperationSuccess(context, TfLoginOperation(), user);
          } catch (e) {
            await onAuthOperationFailed(context, TfLoginOperation(), e);
          }
        },
      );
    }
    return const SizedBox();
  }

  Widget _buildSocialLoginButton(
      {required BuildContext context,
      required String iconAssetPath,
      required VoidCallback onPressed}) {
    return Padding(
      padding: EdgeInsets.all(tfImage(4)),
      child: GestureDetector(
        onTap: onPressed,
        child: CircleAvatar(
          backgroundColor: rsc.socialLoginButtonBackgroundColor(context),
          radius: tfImage(6.5),
          child: Padding(
            padding: EdgeInsets.all(tfImage(3.4)),
            child: Image.asset(
              iconAssetPath,
              fit: BoxFit.contain,
              package: "tf_auth_page",
            ),
          ),
        ),
      ),
    );
  }
}
