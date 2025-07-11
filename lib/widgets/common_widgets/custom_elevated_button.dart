// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:all_star_learning/config/theme/app_static_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class KElevatedButton extends StatelessWidget {
  final void Function()? onPressed;
  final String label;
  final double? width;
  final double? borderRadius;
  final bool isDisabled;
  const KElevatedButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.width,
    this.borderRadius,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isDisabled ? AppColors.colorsGrey300 : AppColors.mainColor,
        foregroundColor: isDisabled ? Colors.white60 : Colors.white,
        minimumSize: Size(width ?? 1.sw, 45.h),
        maximumSize: Size(width ?? 1.sw, 45.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 0),
        )
      ),
      onPressed: isDisabled ? null : onPressed,
      child: Center(
        child: Text(
          label,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: isDisabled ? Colors.white60 :Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
