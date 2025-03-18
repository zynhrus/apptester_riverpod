import 'package:app_riverpod/core/screen/screen_input.dart';
import 'package:app_riverpod/core/screen/screen_output.dart';

class Submission3Input extends ScreenInput {
  final String formData;
  
  const Submission3Input({required this.formData});
  
  @override
  Map<String, String> toQueryParams() => {
    'formData': formData,
  };
}

class Submission3Output extends ScreenOutput {
  final String result;
  
  const Submission3Output({required this.result});
}