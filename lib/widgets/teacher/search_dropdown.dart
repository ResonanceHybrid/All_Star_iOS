import 'package:all_star_learning/config/theme/app_static_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchDropDown extends StatelessWidget {
  const SearchDropDown({
    super.key,
    this.hintText,
    required this.data,
    required this.onChanged,
    this.value,
    this.isMonth = false,
    this.name,
  });

  final String? hintText;
  final List<dynamic> data;
  final Function(dynamic) onChanged;
  final String? value;
  final bool isMonth;
  final String Function(int? index)? name;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(hintText != null)
         Padding(
           padding: EdgeInsets.only(bottom: 8.h),
           child: Text(
            hintText!,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: AppColors.textDarkColorGrey,
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        DropdownButtonFormField(
          itemHeight: 48,
          // menuMaxHeight: 300,
          dropdownColor: Colors.white,
          decoration: InputDecoration(
            errorStyle: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: Colors.red),
            contentPadding: EdgeInsets.symmetric(vertical: 2.0.h, horizontal: 10.0.w),
            border: const OutlineInputBorder(),
            hintStyle: TextStyle(fontFamily: "Lexend", fontSize: 12.sp),
            filled: true,
            enabled: false,
            fillColor: Colors.grey.shade200,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.r),
              borderSide: BorderSide(
                color: Colors.grey.shade400,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.r),
              borderSide: const BorderSide(
                color: Colors.red,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.r),
              borderSide: BorderSide(
                color: Colors.grey.shade400,
              ),
            ),
          ),
          value: value,
          icon: const Icon(Icons.keyboard_arrow_down),
          items: data.map((dynamic value) {
            return DropdownMenuItem<dynamic>(
              value: value.id.toString(),
              child: Container(
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  border: Border(
                    top: data.indexOf(value) != 0 ? BorderSide(
                      color: AppColors.colorsGrey300,
                    ) : BorderSide.none,
                  )
                ),
                child: Text(
                  name != null ? name!(data.indexOf(value)) : value.name,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: isMonth && value.isCurrentMonth == 1 ? AppColors.mainColor : AppColors.textDarkColorGrey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
