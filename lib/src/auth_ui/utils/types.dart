import 'package:flutter/cupertino.dart';

import '../models/tf_auth_operations.dart';

typedef TfAuthOperationSuccessCallback = Future<void> Function(
    BuildContext context, TfAuthOperation operation);

typedef TfAuthOperationFailureCallback = Future<void> Function(
    BuildContext context, TfAuthOperation operation, dynamic error);

typedef TfAuthCancelled = Future<void> Function(BuildContext context);
