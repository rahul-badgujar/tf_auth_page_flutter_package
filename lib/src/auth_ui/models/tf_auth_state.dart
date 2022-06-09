import 'dart:async';

import 'package:tf_auth_page/src/auth_ui/errors/tf_auth_state_exceptions.dart';
import 'package:tf_auth_page/tf_auth_page.dart';

class TfAuthController {
  TfAuthController._privateConstructor();
  static final instance = TfAuthController._privateConstructor();

  bool __initialized = false;

  late final TfAuth _authProvider;

  /// Initialize the instance.
  void init({required TfAuth authProvider}) {
    _authProvider = authProvider;
    __initialized = true;
  }

  TfAuth get authProvider {
    __checkInstanceInitialized();
    return _authProvider;
  }

  /// Stream of user changes to act on user changes.
  Stream<TfAuthUser?> get userChanges {
    return authProvider.userChangesStream;
  }

  /// Current User logged in the app
  TfAuthUser? get currentUser {
    return authProvider.currentUser;
  }

  /// Returns `true` if user is not logged in
  bool get isUserNotLoggedIn {
    return authProvider.isUserNotLoggedIn;
  }

  /// Returns `true` if user is logged in
  bool get isUserLoggedIn {
    return authProvider.isUserLoggedIn;
  }

  /// Logout the currently logged in user
  Future<void> logout() async {
    await authProvider.logout();
  }

  /// Confirms that TfAuthState is initialized.
  void __checkInstanceInitialized() {
    if (!__initialized) {
      throw TfAuthStateNotInitialized();
    }
  }
}
