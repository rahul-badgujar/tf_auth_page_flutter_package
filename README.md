### tf_auth_page

TfAuthPage is a Login/Signup Page UI under Tenfins TfAuth Library.

## Features

Provides customizations for:

- Social Logins required
- Authentication Provider
- Callbacks to get called when any operation results

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

Add the TfAuthPage widget in your UI

```dart
TfAuthPage(
    // List of social auth's you want to support
    socialLoginsRequired: const [
        SocialLoginType.google,
        SocialLoginType.facebook,
        SocialLoginType.apple,
    ],
    // Auth implementation you want to use
    // E.g., TfAuthFirebase, TfAuthPostgres etc.
    authProvider:
        TfAuthFirebase(firebaseAuthInstance: FirebaseAuth.instance),
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
          context, 'Logged in successfully (uid:${user.email})');
    } else if (operation is TfSignupOperation) {
      showMessagedSnackbar(
          context, 'Registered successfully (uid:${user.email})');
    } else if (operation is TfForgotPasswordOperation) {
      showMessagedSnackbar(
          context, 'Resetted password successfully (uid:${user.email})');
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

## Additional information

### TfAuthOperations

The TfAuthOperations represent different Authentication Operations.
Currently we have 3 operations defined

- TfLoginOperation
- TfSignupOperation
- TfForgotPasswordOperation


