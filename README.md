### tf_auth_page

TfAuthPage is a Login/Signup Page UI under Tenfins TfAuth Library.

## Getting started

Add dependency in your pubspec.yaml

```yaml
tf_auth_page:
    git:
      url: https://github.com/rahul-badgujar/tf_auth_page_flutter_package.git
      ref: main
```

Import the dependency in your codebase

```dart
import 'package:tf_auth_page/tf_auth_page.dart';
```

## Usage

Make sure you initialize TfAuthController instance before using any functionality.

```dart
TfAuthController.instance.init(
    authProvider: TfAuthFirebase(
      firebaseAuthInstance: FirebaseAuth.instance,
    ),
  );
```

### Using TfAuthPage Widget

Add the TfAuthPage widget in your UI

```dart
TfAuthPage(
    // List of social auth's you want to support
    socialLoginsRequired: const [
        SocialLoginType.google,
        SocialLoginType.facebook,
        SocialLoginType.apple,
    ],
    // Callback called when any auth operation results success
    onAuthOperationSuccess: _onAuthOperationSuccess,
    // Callback called when any auth operation results failure
    onAuthOperationFailed: _onAuthOperationFailed,
    // Callback called when auth is cancelled i.e, Auth Page is cancelled.
    onCancel: _onCancel,
),
```

Provide the callbacks to get executed when operation results

```dart
// Callback called when any auth operation results success
Future<void> _onAuthOperationSuccess(BuildContext context, TfAuthOperation operation, TfAuthUser? user) async {
    // Perform action you want depending on Operation Type
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

// Callback called when any auth operation results failure
Future<void> _onAuthOperationFailed(BuildContext context, TfAuthOperation operation, dynamic error) async {
    // Perform action you want depending on Operation Type
    if (operation is TfLoginOperation) {
      showMessagedSnackbar(context, 'Failed to login: $error');
    } else if (operation is TfSignupOperation) {
      showMessagedSnackbar(context, 'Failed to register: $error');
    } else if (operation is TfForgotPasswordOperation) {
      showMessagedSnackbar(context, 'Failed to reset password: $error');
    }
}

// Callback called when auth is cancelled i.e, Auth Page is cancelled.
Future<void> _onCancel(BuildContext context) async {
    showMessagedSnackbar(context, 'Authentication cancelled.');
}
```

### Using TfAuthController to access states and features

```dart

/* 
    TfAuthController is a singletone providing all the auth features. 
    You can access it from anywhere in the code.
*/

// You can access the Auth Provider setted up.
TfAuth authProvider = TfAuthController.instance.authProvider;

// Easily access the current logged in user if exists, otherwise it returns null
TfAuthUser? currentUser= TfAuthController.instance.currentUser;

// You can even listen to Auth User changes by subscribing to userChanges stream.
TfAuthController.instance.userChanges.listen((user) {
    if (user == null) {
        print("User Change Listened: no-user");
    } else {
        print("User Change Listened: ${user.uid}");
    }
});

/// Check if a user is logged in.
if (TfAuthController.instance.isUserLoggedIn) {
    print("User is logged in.");
}

// Check if no user is logged in.
if (TfAuthController.instance.isUserNotLoggedIn) {
    print("No user has logged in.");
}

// You can logout the user from anywhere in the code.
await TfAuthController.instance.logout();
```

## Additional information

### TfAuthOperations

The TfAuthOperations represent different Authentication Operations.
Currently we have 3 operations defined

- TfLoginOperation
- TfSignupOperation
- TfForgotPasswordOperation

### TfAuth Architecture

[See TfAuth Architecture Diagram](https://lucid.app/lucidspark/ee7c8841-9540-4926-9f3f-e59f43e2da71/edit?viewport_loc=504%2C14%2C2972%2C1464%2C0_0&invitationId=inv_5ba614d7-3168-4a8e-8197-73dacba538f8#)

Note: You will require LucidChart Account to view the above diagram. If you don't have account, [create account and login](https://lucid.app/users/login#/login).
