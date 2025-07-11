import 'package:all_star_learning/Pages/TeacherPages/TeacherHome/cubit/home_container_cubit.dart';
import 'package:all_star_learning/new/core/dependency_injection/dependency_injection.dart';

class HomeContainerDI {
  register() {
    locator.registerLazySingleton(() => HomeContainerCubit(
    ));
  }
}
