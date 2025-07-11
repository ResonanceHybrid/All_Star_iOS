import 'package:all_star_learning/config/theme/app_static_colors.dart';
import 'package:flutter/material.dart';

class AttendanceReportDropdown extends StatelessWidget {
  const AttendanceReportDropdown({
    super.key,
    required this.context,
    required this.hintText,
    required this.data,
    required this.onChanged,
    required this.value,
  });

  final BuildContext context;

  final String hintText;
  final List<dynamic> data;
  final Function(String? p1) onChanged;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Theme.of(context).cardColor,
      ),
      child: DropdownButtonFormField(
        value: value,
        icon: const SizedBox(),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          hintMaxLines: 1,
          hintStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: AppColors.mainColor, fontWeight: FontWeight.w600),
        ),
        items: data.map((dynamic value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: AppColors.mainColor, fontWeight: FontWeight.w600),
            ),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}
