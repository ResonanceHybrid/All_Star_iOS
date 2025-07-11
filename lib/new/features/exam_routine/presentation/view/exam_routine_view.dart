import 'package:all_star_learning/config/theme/app_static_colors.dart';
import 'package:all_star_learning/new/features/exam_routine/presentation/cubit/exam_routine_cubit.dart';
import 'package:all_star_learning/new/features/exam_routine/presentation/cubit/exam_routine_state.dart';
import 'package:all_star_learning/utils/custom_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExamRoutinePage extends StatefulWidget {
  const ExamRoutinePage({super.key});

  @override
  State<ExamRoutinePage> createState() => _SubjectPageState();
}

class _SubjectPageState extends State<ExamRoutinePage> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<ExamRoutineCubit>(context).clear();
    BlocProvider.of<ExamRoutineCubit>(context).getExamList();
  }

  CustomMethods cm = CustomMethods();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExamRoutineCubit, ExamRoutineState>(
      builder: (context, state) {
        return Scaffold(
          appBar: cm.getAppBarWithTitle(context, "Exam Routine"),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                Text(
                  "Select Exam",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                // Dropdown to select classes
                DropdownButtonFormField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade300,
                    enabled: true,
                    border: const OutlineInputBorder(),
                  ),
                  value: state.examEntityList?.isNotEmpty ?? false
                      ? state.examEntityList?.first.id
                      : null,
                  items: state.examEntityList
                      ?.map(
                        (e) => DropdownMenuItem(
                          value: e.id,
                          child: Text(e.name ?? ""),
                        ),
                      ).toList(),
                  onChanged: (value) {
                    BlocProvider.of<ExamRoutineCubit>(context).getExamRoutine(
                      examId: value ?? 0,
                      classId: 0,
                    );
                  },
                ),
                const SizedBox(height: 40),
                Column(
                  children: [
                    state.isLoading
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
                            : state.examRoutineEntity == null ||
                                    state.examRoutineEntity!.routine!.isEmpty
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
                                    border: TableBorder.all(
                                      width: 1, 
                                      color: Colors.black,
                                    ),
                                    children: [
                                      TableRow(
                                        decoration: BoxDecoration(
                                          color: AppColors.mainColor
                                              .withOpacity(0.2),
                                        ),
                                        children: [
                                          Container(
                                            alignment: Alignment.center,
                                            padding: const EdgeInsets.all(10),
                                            child: Text('S.N',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium!
                                                    .copyWith(
                                                      color:
                                                          AppColors.mainColor,
                                                    )),
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
                                      ...state.examRoutineEntity!.routine!
                                          .map((e) {
                                        return TableRow(
                                          children: [
                                            Container(
                                              alignment: Alignment.center,
                                              padding: const EdgeInsets.all(10),
                                              child: Text(
                                                  "${state.examRoutineEntity!.routine!.indexOf(e) + 1}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge),
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
                                                          .subject ??
                                                      "N/A",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge),
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
                                                          .date ??
                                                      "N/A",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge),
                                            ),
                                          ],
                                        );
                                      })
                                    ],
                                  ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
