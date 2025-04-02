import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fmf_dsl/fl_form/fl_form.dart';

class BuildAddressWidget extends StatelessWidget {
  const BuildAddressWidget({
    super.key,
    required this.addressController,
  });

  final TextEditingController addressController;

  @override
  Widget build(BuildContext context) {
    return FLForm.textInput(
      enableInteractiveSelection: false,
      controller: addressController,
      labelText: 'Alamat Rumah',
      isRequired: true,
      hintText: 'Contoh: Jalan Mawar',
      actionKeyboard: TextInputAction.unspecified,
      inputFormatters: [
        LengthLimitingTextInputFormatter(100),
      ],
      validationMessages: {
        ValidationMessage.required: ValidationData(
          message: "Alamat rumah tidak boleh kosong",
        ),
        ValidationMessage.minCharacter: ValidationData.minCharacter(
          message: "Alamat rumah minimal 3 karakter",
          minCharacter: 3,
        ),
        ValidationMessage.maxCharacter: ValidationData.character(
          message: "Alamat rumah maksimal 100 karakter",
          maxCharacter: 100,
        ),
      },
    );
  }
}
