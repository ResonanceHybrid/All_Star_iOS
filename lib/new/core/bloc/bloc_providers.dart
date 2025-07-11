import 'package:all_star_learning/Pages/TeacherPages/TeacherHome/cubit/home_container_cubit.dart';
import 'package:all_star_learning/new/core/dependency_injection/dependency_injection.dart';
import 'package:all_star_learning/new/features/call_log/presentation/cubit/call_log_cubit.dart';
import 'package:all_star_learning/new/features/complain_box/presentation/cubit/complain_box_cubit.dart';
import 'package:all_star_learning/new/features/exam_routine/presentation/cubit/exam_routine_cubit.dart';
import 'package:all_star_learning/new/features/leave/presentation/cubit/leave_cubit.dart';
import 'package:all_star_learning/new/features/qr/presentation/cubit/qr_cubit.dart';
import 'package:all_star_learning/new/features/student_list/presentation/cubit/student_list_cubit.dart';
import 'package:all_star_learning/new/features/videos/presentation/cubit/videos_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocProvidersList {
  static get blocProvidersList => [
        BlocProvider(create: (context) => locator<QrCubit>()),
        BlocProvider(create: (context) => locator<LeaveCubit>()),
        BlocProvider(create: (context) => locator<StudentListCubit>()),
        BlocProvider(create: (context) => locator<ComplainBoxCubit>()),
        BlocProvider(create: (context) => locator<VideosCubit>()),
        BlocProvider(create: (context) => locator<CallLogCubit>()),
        BlocProvider(create: (context) => locator<ExamRoutineCubit>()),
        BlocProvider(create: (context) => locator<HomeContainerCubit>()),
      ];
}
