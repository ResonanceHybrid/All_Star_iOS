import 'package:all_star_learning/config/theme/app_static_colors.dart';
import 'package:flutter/material.dart';

class AttandanceDropdown extends StatelessWidget {
  const AttandanceDropdown(
      {super.key,
      required this.hintText,
      required this.data,
      required this.onChanged,
      this.value});
  final String hintText;
  final List<dynamic> data;
  final Function(dynamic) onChanged;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 10),
      child: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Theme.of(context).cardColor,
        ),
        child: DropdownButtonFormField(
          value: value,
          icon: const SizedBox(),
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: AppColors.mainColor, fontWeight: FontWeight.bold)),
          items: data.map((dynamic value) {
            return DropdownMenuItem<dynamic>(
              value: value.id.toString(),
              child: Text(value.name,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: AppColors.mainColor, fontWeight: FontWeight.w600)),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
