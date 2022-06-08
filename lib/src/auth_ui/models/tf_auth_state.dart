import 'dart:async';

import 'package:tf_auth_page/src/auth_ui/errors/tf_auth_state_exceptions.dart';
import 'package:tf_auth_page/tf_auth_page.dart';

class TfAuthState {
  TfAuthState._privateConstructor();
  static final instance = TfAuthState._privateConstructor();

  bool __initialized = false;

  TfAuthUser? _currentUser;
  late final TfAuth _authProvider;

  /// Initialize the instance.
  void init({required TfAuth authProvider}) {
    _authProvider = authProvider;
    __initialized = true;
  }

  final StreamController<TfAuthUser?> _userChangesStreamController =
      StreamController<TfAuthUser?>.broadcast();

  /// Stream of user changes to act on user changes.
  Stream<TfAuthUser?> get userChanges {
    return _userChangesStreamController.stream;
  }

  /// Current User logged in the app
  TfAuthUser? get currentUser {
    return _currentUser;
  }

  /// Update the current user
  set currentUser(TfAuthUser? newCurrentUser) {
    currentUser = newCurrentUser;
    _userChangesStreamController.sink.add(currentUser);
  }

  /// Returns `true` if user is not logged in
  bool get isUserNotLoggedIn {
    return currentUser == null;
  }

  /// Returns `true` if user is logged in
  bool get isUserLoggedIn {
    return !isUserNotLoggedIn;
  }

  /// Logout the currently logged in user
  Future<void> logout() async {
    __checkInstanceInitialized();

    await _authProvider.logout();
    currentUser = null;
  }

  void __checkInstanceInitialized() {
    if (!__initialized) {
      throw TfAuthStateNotInitialized();
    }
  }
}
