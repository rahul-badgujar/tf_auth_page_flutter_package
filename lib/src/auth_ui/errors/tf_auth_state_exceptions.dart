// ignore_for_file: constant_identifier_names

abstract class TfAuthStateException {
  final String errorCode;
  final String title;
  final String detail;

  TfAuthStateException(
      {required this.errorCode, required this.title, required this.detail});
}

class TfAuthStateNotInitialized extends TfAuthStateException {
  static const ERROR_CODE = "tf-auth-state-not-initialized";
  static const TITLE = "TfAuthState not initialized";
  static const DEFAULT_DETAIL =
      "Please call TfAuthState.init() before you use any of functionality provided by TfAuthState";

  TfAuthStateNotInitialized({String? detail})
      : super(
            errorCode: ERROR_CODE,
            title: TITLE,
            detail: detail ?? DEFAULT_DETAIL);
}
