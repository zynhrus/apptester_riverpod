import 'package:app_riverpod/core/screen/screen_input.dart';
import 'package:app_riverpod/core/screen/screen_output.dart';

class Submission1Input extends ScreenInput {
  final String customerId;
  
  const Submission1Input({required this.customerId});
  
  @override
  Map<String, String> toQueryParams() => {
    'customerId': customerId,
  };
}

class Submission1Output extends ScreenOutput {
  final String result;
  
  const Submission1Output({required this.result});
}