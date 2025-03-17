abstract class ScreenInput {
  const ScreenInput();

  // Convert Input parameter ke Map untuk URL Query Parameters
  Map<String, String> toQueryParams() => {};

  // Convert Input ke path parameter jika dibutuhkan
  String? toPathParam() => null;
}