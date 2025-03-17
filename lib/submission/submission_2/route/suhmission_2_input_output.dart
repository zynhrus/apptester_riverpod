import 'package:app_riverpod/core/screen/screen_input.dart';
import 'package:app_riverpod/core/screen/screen_output.dart';

class Submission2Input extends ScreenInput {
  final String formData;
  
  const Submission2Input({required this.formData});
  
  @override
  Map<String, String> toQueryParams() => {
    'formData': formData,
  };
}

class Submission2Output extends ScreenOutput {
  final String result;
  
  const Submission2Output({required this.result});
}