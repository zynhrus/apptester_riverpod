import 'package:app_riverpod/core/screen/screen_input.dart';
import 'package:app_riverpod/core/screen/screen_output.dart';

class DetailTransactionInput extends ScreenInput {
  final String prospectId;
  
  const DetailTransactionInput({required this.prospectId});
  
  @override
  Map<String, String> toQueryParams() => {
    'prospectId': prospectId,
  };
}

class DetailTransactionOutput extends ScreenOutput {
  final String result;
  
  const DetailTransactionOutput({required this.result});
}