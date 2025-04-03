import 'package:flutter/material.dart';
import 'package:fmf_dsl/fl_color/fl_color.dart';

ITokens defaultToken = DefaultTokens();

class BottomSheetListTile extends StatelessWidget {
  final Widget body;
  final VoidCallback onTap;
  final bool isSelected;

  const BottomSheetListTile({
    super.key,
    required this.body,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? defaultToken.color.kpmPaginationPieceBackgroundSelected
              : null,
          border: Border(
            left: isSelected
                ? BorderSide(
              width: 2,
              color: defaultToken.color.kpmMenuSheetBorderSelected,
            )
                : BorderSide.none,
            bottom: const BorderSide(
              color: FLColor.neutral100,
            ),
          ),
        ),
        child: body,
      ),
    );
  }
}
