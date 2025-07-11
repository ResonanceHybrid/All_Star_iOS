import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContainerWidget extends StatelessWidget {
  const ContainerWidget({
    super.key,
    required this.child,
    this.color,
    this.borderColor,
    this.padding,
    this.radius,
    this.hasShadow = true,
    this.gradient,
  });
  final Widget child;
  final Color? color;
  final double? radius;
  final Color? borderColor;
  final double? padding;
  final bool hasShadow;
  final Gradient? gradient;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: 10.sp),
      padding: EdgeInsets.all(padding ?? 15.sp),
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor ?? Colors.transparent,
        ),
        color: color ?? Colors.white,
        borderRadius: BorderRadius.circular(radius ?? 10.sp),
        boxShadow: hasShadow ? [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ] : [],
        gradient: gradient,
      ),
      child: child,
    );
  }
}
//

class ContainerWidgetWithGradient extends StatelessWidget {
  const ContainerWidgetWithGradient(
      {super.key,
      required this.child,
      this.color,
      this.borderColor,
      this.gradient,
      this.radius});
  final Widget child;
  final Color? color;
  final Color? borderColor;
  final double? radius;
  final LinearGradient? gradient;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: 10.sp),
      padding: EdgeInsets.symmetric(vertical: 5.sp, horizontal: 10.sp),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(radius ?? 20.sp),
      ),
      child: child,
    );
  }
}
