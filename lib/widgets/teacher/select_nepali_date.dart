import 'package:all_star_learning/config/theme/app_static_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart' as picker;
import 'package:nepali_date_picker/nepali_date_picker.dart';

class SelectNepaliDate extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool? showSuffixIcon;
  final IconData? suffixIcon;
  final Function()? onDateAdded;
  final bool isTo;

  const SelectNepaliDate(
      {super.key,
      required this.controller,
      required this.hintText,
      this.suffixIcon = Icons.calendar_today_outlined,
      this.showSuffixIcon = false,
      this.onDateAdded,
      this.isTo = false});

  @override
  State<SelectNepaliDate> createState() => _SelectNepaliDateState();
}

class _SelectNepaliDateState extends State<SelectNepaliDate> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 10),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade400,
        ),
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: TextFormField(
        readOnly: true,
        onTap: () async {
          picker
              .showMaterialDatePicker(
            context: context,
            initialDate: NepaliDateTime.now(),
            firstDate: NepaliDateTime(2000),
            lastDate: NepaliDateTime(2090),
            initialDatePickerMode: DatePickerMode.day,
            builder: (BuildContext context, Widget? child) {
              return Theme(
                data: ThemeData.light().copyWith(
                  dialogTheme: DialogThemeData(
                    surfaceTintColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                  primaryColor: AppColors.mainColor,
                  buttonTheme: const ButtonThemeData(
                    textTheme: ButtonTextTheme
                        .primary, // This will change to light theme.
                  ),
                  colorScheme: const ColorScheme.light(
                    primary: AppColors.mainColor,
                  ).copyWith(
                    secondary: AppColors.mainColor,
                  ),
                ),
                child: child!,
              );
            },
          )
              .then((value) {
            if (value == null) return;
            setState(() {
              String month =
                  value.month < 10 ? "0${value.month}" : "${value.month}";
              String day = value.day < 10 ? "0${value.day}" : "${value.day}";
              widget.controller.text = "${value.year}-$month-$day";
            });

            if (widget.isTo) {
              widget.onDateAdded!();
            }
          });
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: widget.hintText,
          hintStyle: const TextStyle(
            color: AppColors.mainColor,
            fontWeight: FontWeight.bold,
          ),
          suffixIcon: widget.showSuffixIcon!
              ? Icon(
                  widget.suffixIcon,
                  color: AppColors.mainColor,
                )
              : null,
        ),
        autofocus: false,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Required field *";
          }
          return null;
        },
        controller: widget.controller,
        style: Theme.of(context).textTheme.labelLarge!.copyWith(
              color: AppColors.textColorLightGrey,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
      ),
    );
  }
}
