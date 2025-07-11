import 'package:all_star_learning/Utils/custom_methods.dart';
import 'package:all_star_learning/new/features/call_log/presentation/cubit/call_log_cubit.dart';
import 'package:all_star_learning/new/features/call_log/presentation/cubit/call_log_state.dart';
import 'package:all_star_learning/new/features/student_list/presentation/view/pages/student_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CallLogDetailPage extends StatefulWidget {
  const CallLogDetailPage({super.key});

  @override
  State<CallLogDetailPage> createState() => _CallLogDetailPageState();
}

class _CallLogDetailPageState extends State<CallLogDetailPage> {
  CustomMethods cm = CustomMethods();

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CallLogCubit, CallLogState>(
      builder: (context, state) {
        return Scaffold(
          appBar: cm.getAppBarWithTitle(context, "Call Logs"),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0).copyWith(top: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DetailTextWidget(
                  title: "Called By", 
                  detail: state.selectedCallLog?.callBy ?? "N/A",
                ),
                SizedBox(height: 16.h),
                DetailTextWidget(
                  title: "Called To", 
                  detail: state.selectedCallLog?.callTo ?? "N/A",
                ),
                SizedBox(height: 16.h),
                DetailTextWidget(
                  title: "Phone No", 
                  detail: state.selectedCallLog?.phone ?? 'N/A',
                ),
                SizedBox(height: 16.h),
                DetailTextWidget(
                  title: "Call Duration",
                  detail: "${state.selectedCallLog?.duration ?? 'N/A'}",
                ),
                SizedBox(height: 16.h),
                DetailTextWidget(
                  title: "Call Type",
                  detail: state.selectedCallLog?.callType ?? 'N/A',
                ),
                SizedBox(height: 16.h),
                Text(
                  "Purpose",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  state.selectedCallLog?.purpose ?? 'N/A',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp,
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  "Remarks",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  state.selectedCallLog?.remarks ?? 'N/A',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
