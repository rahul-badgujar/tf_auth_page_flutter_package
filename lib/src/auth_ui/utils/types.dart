import 'package:flutter/cupertino.dart';
import 'package:tf_auth_page/tf_auth_page.dart';

typedef TfAuthOperationSuccessCallback = Future<void> Function(
    BuildContext context, TfAuthOperation operation, TfAuthUser? user);

typedef TfAuthOperationFailureCallback = Future<void> Function(
    BuildContext context, TfAuthOperation operation, dynamic error);

typedef TfAuthCancelled = Future<void> Function(BuildContext context);
