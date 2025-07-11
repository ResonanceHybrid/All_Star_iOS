import 'package:all_star_learning/new/core/dependency_injection/dependency_injection.dart';
import 'package:all_star_learning/new/features/exam_routine/data/data_source/remote/exam_routine_remote_data_source.dart';
import 'package:all_star_learning/new/features/exam_routine/data/repository/exam_routine_repository_impl.dart';
import 'package:all_star_learning/new/features/exam_routine/domain/repository/exam_routine_repository.dart';
import 'package:all_star_learning/new/features/exam_routine/domain/usecase/get_exam_list_usecase.dart';
import 'package:all_star_learning/new/features/exam_routine/domain/usecase/get_exam_routine_usecase.dart';
import 'package:all_star_learning/new/features/exam_routine/presentation/cubit/exam_routine_cubit.dart';

class ExamRoutineDI {
  register() {
    locator.registerFactory(
      () => ExamRoutineRemoteDataSource(
        api: locator(),
      ),
    );
    locator.registerFactory<IExamRoutineRepository>(
      () => ExamRoutineRepositoryImpl(
        remoteDataSource: locator(),
      ),
    );

    locator.registerFactory(
      () => GetExamRoutineUsecase(
        repository: locator(),
      ),
    );
    locator.registerFactory(
      () => GetExamListUsecase(
        repository: locator(),
      ),
    );

    locator.registerLazySingleton(() => ExamRoutineCubit(
          getExamRoutineUseCase: locator(),
          getExamListUseCase: locator(),
        ));
  }
}
