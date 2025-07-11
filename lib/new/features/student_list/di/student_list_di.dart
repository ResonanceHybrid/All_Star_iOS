import 'package:all_star_learning/new/core/dependency_injection/dependency_injection.dart';
import 'package:all_star_learning/new/features/student_list/data/data_source/remote/student_list_remote_data_source.dart';
import 'package:all_star_learning/new/features/student_list/data/repository/student_list_repository_impl.dart';
import 'package:all_star_learning/new/features/student_list/domain/repository/student_list_repository.dart';
import 'package:all_star_learning/new/features/student_list/domain/usecase/get_all_class_list_usecase.dart';
import 'package:all_star_learning/new/features/student_list/domain/usecase/get_all_section_list_of_class_usecase.dart';
import 'package:all_star_learning/new/features/student_list/domain/usecase/get_all_student_list_usecase.dart';
import 'package:all_star_learning/new/features/student_list/presentation/cubit/student_list_cubit.dart';

class StudentListDI {
  void register() {
    locator.registerFactory(() => StudentListRemoteDataSource(api: locator()));
    locator.registerFactory<IStudentListRepository>(
        () => StudentListRepositoryImpl(
              remoteDataSource: locator(),
            ));
    locator.registerFactory(() => GetStudentListUsecase(locator()));
    locator.registerFactory(() => GetClassListUsecase(locator()));
    locator.registerFactory(() => GetClassSectionListUsecase(locator()));

    locator.registerLazySingleton(
      () => StudentListCubit(
        getStudentListUsecase: locator(),
        getClassListUsecase: locator(),
        getClassSectionListUsecase: locator(),
      ),
    );
  }
}
