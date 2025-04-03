import 'package:app_riverpod/core/resources/date_manager.dart';
import 'package:app_riverpod/module/submission/common/bottom_sheet/bottom_sheet_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:fmf_dsl/fl_bottom_sheet/fl_bottom_sheet.dart';
import 'package:fmf_dsl/fl_form/fl_form.dart';
import 'package:fmf_dsl/fl_text/fl_text.dart';
import 'package:go_router/go_router.dart';

class BuildStartDateWidget extends StatelessWidget {
  const BuildStartDateWidget({
    super.key,
    required this.startMonthController,
    required this.startYearController,
    required this.onSelectMonth,
    required this.onSelectYear,
  });

  final TextEditingController startMonthController;
  final TextEditingController startYearController;
  final Function(String month) onSelectMonth;
  final Function(String year) onSelectYear;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: FLForm.textInput(
      enableInteractiveSelection: false,
            controller: startMonthController,
            labelText: 'Tanggal Sejak',
            isRequired: true,
            hintText: 'Desember',
            focusNode: FocusNode(),
            suffixIcon: Icons.keyboard_arrow_down,
            readOnly: true,
            onFieldTap: () {
              FocusScope.of(context).unfocus();

              _showStartMonthBottomSheet(context);
            },
            validationMessages: {
              ValidationMessage.required: ValidationData(
                message: "Bulan tidak boleh kosong",
              ),
            },
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: FLForm.textInput(
      enableInteractiveSelection: false,
            controller: startYearController,
            labelText: '',
            hintText: '2018',
            suffixIcon: Icons.keyboard_arrow_down,
            readOnly: true,
            focusNode: FocusNode(),
            onFieldTap: () {
              FocusScope.of(context).unfocus();

              _showStartYearBottomSheet(context);
            },
            validationMessages: {
              ValidationMessage.required: ValidationData(
                message: "Tahun tidak boleh kosong",
              ),
            },
          ),
        ),
      ],
    );
  }

  void _showStartMonthBottomSheet(BuildContext context) {
    FLBottomSheetUtil().showBottomSheetCustomBody(
      context,
      title: 'Bulan',
      body: Container(
        margin: const EdgeInsets.only(top: 12),
        height: MediaQuery.of(context).size.height * 0.5,
        child: ListView.builder(
          itemCount: months.length,
          itemBuilder: (context, index) {
            return BottomSheetListTile(
              body: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 16,
                ),
                child: FLTextView(
                  text: months[index],
                ),
              ),
              onTap: () {
                onSelectMonth(months[index]);
                context.pop();
                FocusScope.of(context).unfocus();
              },
              isSelected: months[index] == startMonthController.text,
            );
          },
        ),
      ),
    ).whenComplete(() {
      FocusScope.of(context).unfocus();
    });
  }

  void _showStartYearBottomSheet(BuildContext context) {
    FLBottomSheetUtil().showBottomSheetCustomBody(
      context,
      title: 'Tahun',
      body: _startYearList(context),
    ).whenComplete(() {
      FocusScope.of(context).unfocus();
    });
  }

  Widget _startYearList(BuildContext context) {
    final int currentYear = DateTime.now().year;
    final List<String> years = List.generate(
        currentYear - 1900 + 1, (index) => (currentYear - index).toString());

    return Container(
      margin: const EdgeInsets.only(top: 12),
      height: MediaQuery.of(context).size.height * 0.4,
      child: ListView.builder(
        itemCount: years.length,
        itemBuilder: (context, index) {
          return BottomSheetListTile(
            body: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 16,
              ),
              child: FLTextView(
                text: years[index],
              ),
            ),
            onTap: () {
              onSelectYear(years[index]);
              context.pop();
              FocusScope.of(context).unfocus();
            },
            isSelected: years[index] == startYearController.text,
          );
        },
      ),
    );
  }
}
