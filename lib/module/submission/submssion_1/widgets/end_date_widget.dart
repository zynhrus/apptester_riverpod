import 'package:app_riverpod/core/resources/date_manager.dart';
import 'package:app_riverpod/module/submission/common/bottom_sheet/bottom_sheet_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:fmf_dsl/fl_bottom_sheet/fl_bottom_sheet.dart';
import 'package:fmf_dsl/fl_form/fl_form.dart';
import 'package:fmf_dsl/fl_text/fl_text.dart';
import 'package:go_router/go_router.dart';

class BuildEndDateWidget extends StatelessWidget {
  const BuildEndDateWidget({
    super.key,
    required this.endMonthController,
    required this.endYearController,
    required this.onSelectMonth,
    required this.onSelectYear,
  });

  final TextEditingController endMonthController;
  final TextEditingController endYearController;
  final Function(String month) onSelectMonth;
  final Function(String year) onSelectYear;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: FLForm.textInput(
        enableInteractiveSelection: false,
            controller: endMonthController,
            labelText: 'Tanggal Berakhir Sewa',
            isRequired: true,
            hintText: 'Desember',
            focusNode: FocusNode(),
            suffixIcon: Icons.keyboard_arrow_down,
            readOnly: true,
            onFieldTap: () {
              FocusScope.of(context).unfocus();

              _showEndMonthBottomSheet(context);
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
            controller: endYearController,
            labelText: '',
            hintText: '2018',
            focusNode: FocusNode(),
            suffixIcon: Icons.keyboard_arrow_down,
            readOnly: true,
            onFieldTap: () {
              FocusScope.of(context).unfocus();

              _showEndYearBottomSheet(context);
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

  void _showEndMonthBottomSheet(BuildContext context) {
    FLBottomSheetUtil().showBottomSheetCustomBody(
      context,
      title: 'Bulan',
      body: Container(
        margin: const EdgeInsets.only(top: 12),
        height: MediaQuery.of(context).size.height * 0.4,
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
              isSelected: months[index] == endMonthController.text,
            );
          },
        ),
      ),
    ).whenComplete(() {
      FocusScope.of(context).unfocus();
    });
  }

  void _showEndYearBottomSheet(BuildContext context) {
    FLBottomSheetUtil().showBottomSheetCustomBody(
      context,
      title: 'Tahun',
      body: _endYearList(context),
    ).whenComplete(() {
      FocusScope.of(context).unfocus();
    });
  }

  Widget _endYearList(BuildContext context) {
    final int currentYear = DateTime.now().year;
    final List<String> years = List.generate(
      21,
      (index) => (currentYear + index).toString(),
    );

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
            isSelected: years[index] == endYearController.text,
          );
        },
      ),
    );
  }
}
