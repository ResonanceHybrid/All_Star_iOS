import 'package:all_star_learning/new/core/errors/error_handler.dart';
import 'package:dartz/dartz.dart';

abstract class Usecase<Type, Params> {
  Future<Either<AppErrorHandler, Type>> call(Params params);
}
