import 'package:all_star_learning/Utils/custom_methods.dart';
import 'package:all_star_learning/new/features/call_log/domain/entities/call_log_entity.dart';
import 'package:all_star_learning/new/features/call_log/presentation/cubit/call_log_cubit.dart';
import 'package:all_star_learning/new/features/call_log/presentation/cubit/call_log_state.dart';
import 'package:all_star_learning/new/features/call_log/presentation/pages/call_log_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CallLogView extends StatefulWidget {
  const CallLogView({super.key});

  @override
  State<CallLogView> createState() => _CallLogViewState();
}

class _CallLogViewState extends State<CallLogView> {
  CustomMethods cm = CustomMethods();

  @override
  initState() {
    super.initState();
    context.read<CallLogCubit>().getAllCallLogs();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CallLogCubit, CallLogState>(
      builder: (context, state) {
        return Scaffold(
          appBar: cm.getAppBarWithTitle(context, "Call Logs"),
          body: Padding(
            padding: const EdgeInsets.only(left: 10, top: 0, right: 8),
            child: state.isLoading
              ? const Center(child: CircularProgressIndicator())
              : state.isSuccess
                  ? ListView.builder(
                      itemCount: state.callLogs.length,
                      itemBuilder: (context, index) {
                        CallLogEntity callLog = state.callLogs[index];
                        return GestureDetector(
                          onTap: () {
                            BlocProvider.of<CallLogCubit>(context).setSelectedCallLog(callLog);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CallLogDetailPage(),
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(10.w),
                            margin: EdgeInsets.only(bottom: 10.h, top: 10.h),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 7,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${callLog.callBy ?? 'N/A'} (${callLog.phone ?? 'N/A'})",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                    Text(
                                      callLog.behavior ?? 'N/A',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14.sp,
                                        color: (callLog.behavior == 'Merit'
                                        ? Colors.green
                                        : Colors.red).shade300,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5.h),
                                Row(
                                  children: [
                                    // Incoming or Outgoing Icon
                                    Icon(
                                      callLog.callType == 'incoming'
                                        ? Icons.call_received
                                        : Icons.call_made,
                                      color: Colors.grey,
                                      size: 16.sp,
                                    ),
                                    // Date and Time
                                    Text(
                                      '  •  ${callLog.date ?? 'N/A'} ${callLog.time ?? 'N/A'}',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8.h),
                            
                                // Purpose
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Purpose: ',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 0.7.sw,
                                      child: Text(
                                        callLog.purpose ?? 'N/A',
                                        maxLines: 2,
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Reason: ',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 0.7.sw,
                                      child: Text(
                                        callLog.remarks ?? 'N/A',
                                        maxLines: 2,
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  : const Text('Error'),
          ),
        );
      },
    );
  }
}
