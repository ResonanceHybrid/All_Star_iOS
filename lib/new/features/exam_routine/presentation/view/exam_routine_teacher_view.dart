import 'package:all_star_learning/config/theme/app_static_colors.dart';
import 'package:all_star_learning/new/features/exam_routine/presentation/cubit/exam_routine_cubit.dart';
import 'package:all_star_learning/new/features/exam_routine/presentation/cubit/exam_routine_state.dart';
import 'package:all_star_learning/utils/custom_methods.dart';
import 'package:all_star_learning/widgets/student/container_widget.dart';
import 'package:all_star_learning/widgets/teacher/search_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TeacherExamRoutinePage extends StatefulWidget {
  const TeacherExamRoutinePage({super.key});

  @override
  State<TeacherExamRoutinePage> createState() => _SubjectPageState();
}

class _SubjectPageState extends State<TeacherExamRoutinePage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ExamRoutineCubit>(context).clear();
    BlocProvider.of<ExamRoutineCubit>(context).getClasses(
      isAll: true,
      onError: (error) {
        CustomMethods().showSnackBar(context, error, Colors.red);
      },
    );
  }

  CustomMethods cm = CustomMethods();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExamRoutineCubit, ExamRoutineState>(
      builder: (context, state) {
        ExamRoutineCubit cubit = BlocProvider.of<ExamRoutineCubit>(context);
        return RefreshIndicator.adaptive(
          onRefresh: () async {
            if(state.selectedClass != null && state.selectedExam != null) {
              cubit.getExamRoutine(
                examId: int.parse(state.selectedExam!.id.toString()),
                classId: int.parse(state.selectedClass ?? "0"),
              );
            }
          },
          child: Scaffold(
            appBar: cm.getAppBarWithTitle(context, "Exam Routine"),
            body: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
              ),
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  const SizedBox(height: 20),
                  // Dropdown to select classes
                  SearchDropDown(
                    hintText: "Select Class",
                    data: state.classList, 
                    onChanged: (val) async {
                      cubit.selectClass(classId: val.toString());
                      await cubit.getExamList(classId: int.tryParse(val));
                    },
                  ),
                  const SizedBox(height: 20),
                  // Dropdown to select classes
                  SearchDropDown(
                    value: state.selectedExam?.id?.toString() ?? "0",
                    hintText: "Select Exam",
                    data: state.examEntityList ?? [], 
                    onChanged: (value) {
                      cubit.selectExam(
                        selectedExam: state.examEntityList!.firstWhere((element) => element.id == int.tryParse(value)),
                      );
                      cubit.getExamRoutine(
                        examId: int.parse(value ?? "0"),
                        classId: int.parse(state.selectedClass ?? "0"),
                      );
                    },
                  ),
          
                  const SizedBox(height: 40),
                  Column(
                    children: [
                      ContainerWidget(
                        child: state.isLoading
                          ? const SizedBox(
                              height: 300,
                              child: Center(
                                  child: CircularProgressIndicator(
                                color: AppColors.mainColor,
                              )),
                            )
                          : state.error != null
                            ? SizedBox(
                                height: 300,
                                child: Center(
                                  child: Text(state.error?.message ?? ""),
                                ),
                              )
                            : state.examRoutineEntity == null || state.examRoutineEntity!.routine!.isEmpty
                              ? const SizedBox(
                                  height: 300,
                                  child: Center(
                                    child: Text("No Data Available"),
                                  ),
                                )
                              : Table(
                                  columnWidths: const {
                                    0: FlexColumnWidth(1),
                                    1: FlexColumnWidth(3),
                                    2: FlexColumnWidth(2),
                                  },
                                  border: TableBorder.symmetric(
                                    inside: const BorderSide(
                                      width: 1,
                                      color: AppColors.mainColor,
                                    ),
                                  ),
                                  children: [
                                    TableRow(
                                      children: [
                                        Container(
                                          alignment: Alignment.center,
                                          padding: const EdgeInsets.all(10),
                                          child: Text('S.N',
                                            style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                                color: AppColors.mainColor,
                                              ),
                                          ),
                                        ),
                                        Container(
                                          // alignment: Alignment.center,
                                          padding: const EdgeInsets.all(10),
                                          child: Text(
                                            'Subjects',
                                            style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                                color: AppColors.mainColor,
                                              ),
                                          ),
                                        ),
                                        Container(
                                          // alignment: Alignment.center,
                                          padding: const EdgeInsets.all(10),
                                          child: Text(
                                            'Date',
                                            style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                                color: AppColors.mainColor,
                                              ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    ...state.examRoutineEntity!.routine!.map((e) {
                                      return TableRow(
                                        children: [
                                          Container(
                                            alignment: Alignment.center,
                                            padding: const EdgeInsets.all(10),
                                            child: Text(
                                              "${state.examRoutineEntity!.routine!.indexOf(e) + 1}",
                                              style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge,
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(10),
                                            child: Text(
                                              state
                                                .examRoutineEntity!
                                                .routine![state
                                                    .examRoutineEntity!
                                                    .routine!
                                                    .indexOf(e)]
                                                .subject ?? "N/A",
                                              style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge,
                                            ),
                                          ),
                                          Container(
                                            padding:
                                                const EdgeInsets.all(10),
                                            child: Text(
                                                state.examRoutineEntity!
                                                  .routine![state
                                                    .examRoutineEntity!
                                                    .routine!
                                                    .indexOf(e)]
                                                  .date ??
                                                    "N/A",
                                                style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge,
                                                ),
                                          ),
                                        ],
                                      );
                                    })
                                  ],
                                ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
