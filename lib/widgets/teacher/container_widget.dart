import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TeacherContainerWidget extends StatelessWidget {
  const TeacherContainerWidget(
      {super.key,
      required this.child,
      this.color,
      this.borderColor,
      this.bgColour,
      this.padding,
      this.width,
      this.radius});
  final Widget child;
  final Color? color;
  final Color? borderColor;
  final double? radius;
  final Color? bgColour;
  final double? padding;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: 10.sp),
      padding: EdgeInsets.all(padding ?? 15.sp),
      decoration: BoxDecoration(
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey.shade200,
        //     spreadRadius: 0,
        //     blurRadius: 10,
        //     offset: const Offset(0, 5), // sets position of shadow
        //   ),
        // ],
        border: Border.all(
          color: borderColor ?? Colors.transparent,
        ),
        color: bgColour ?? Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(radius ?? 20.sp),
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
        boxShadow: const [
          BoxShadow(
            color: Colors.deepOrangeAccent,
            spreadRadius: 0,
            blurRadius: 0,
            offset: Offset(0, 5), // sets position of shadow
          ),
        ],
        gradient: gradient,
        borderRadius: BorderRadius.circular(radius ?? 20.sp),
      ),
      child: child,
    );
  }
}
