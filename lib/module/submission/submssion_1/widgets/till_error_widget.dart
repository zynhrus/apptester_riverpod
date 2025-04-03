import 'package:flutter/material.dart';
import 'package:fmf_dsl/fl_text/fl_text.dart';

class TillErrorMessage extends StatelessWidget {
  final String tillErrorMessage;

  const TillErrorMessage({
    required this.tillErrorMessage,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.warning,
          color: defaultToken.color.kpmFormIconError,
          size: 14,
        ),
        const SizedBox(width: 4),
        FLTextView(
          text: tillErrorMessage,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          fontColor: defaultToken.color.kpmFormTextHelperTextError,
        ),
      ],
    );
  }
}
