import 'package:flutter/material.dart';

TextTheme textTheme(BuildContext context) {
  return Theme.of(context).textTheme;
}

TextStyle? tabTitleTextStyle(BuildContext context) {
  final _textTheme = textTheme(context);
  return _textTheme.headline6?.copyWith();
}

TextStyle? guiderTextStyle(BuildContext context) {
  final _textTheme = textTheme(context);
  return _textTheme.bodyMedium;
}

TextStyle? actionButtonsTextStyle(BuildContext context) {
  final _textTheme = textTheme(context);
  return _textTheme.headline6?.copyWith(
    fontWeight: FontWeight.bold,
  );
}
