import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fmf_dsl/fl_form/fl_form.dart';

class BuildRtRwWidget extends StatelessWidget {
  const BuildRtRwWidget({
    super.key,
    required this.rtController,
    required this.rwController,
  });

  final TextEditingController rtController;
  final TextEditingController rwController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: FLForm.textInput(
      enableInteractiveSelection: false,
            controller: rtController,
            labelText: 'RT/RW',
            isRequired: true,
            hintText: 'RT',
            actionKeyboard: TextInputAction.unspecified,
            inputFormatters: [
              LengthLimitingTextInputFormatter(3),
              FilteringTextInputFormatter.digitsOnly,
            ],
            textInputType: TextInputType.number,
            validationMessages: {
              ValidationMessage.required: ValidationData(
                message: "RT tidak boleh kosong",
              ),
              ValidationMessage.minCharacter: ValidationData.minCharacter(
                message: "RT minimal 1 karakter",
                minCharacter: 1,
              ),
              ValidationMessage.maxCharacter: ValidationData.character(
                message: "RT maksimal 3 karakter",
                maxCharacter: 3,
              ),
            },
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: FLForm.textInput(
      enableInteractiveSelection: false,
            controller: rwController,
            labelText: '',
            actionKeyboard: TextInputAction.unspecified,
            inputFormatters: [
              LengthLimitingTextInputFormatter(3),
              FilteringTextInputFormatter.digitsOnly,
            ],
            textInputType: TextInputType.number,
            hintText: 'RW',
            validationMessages: {
              ValidationMessage.required: ValidationData(
                message: "RW tidak boleh kosong",
              ),
              ValidationMessage.minCharacter: ValidationData.minCharacter(
                message: "RW minimal 1 karakter",
                minCharacter: 1,
              ),
              ValidationMessage.maxCharacter: ValidationData.character(
                message: "RW maksimal 3 karakter",
                maxCharacter: 3,
              ),
            },
          ),
        ),
      ],
    );
  }
}
