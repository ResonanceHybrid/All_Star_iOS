import 'package:all_star_learning/new/core/errors/error_handler.dart';
import 'package:all_star_learning/new/features/complain_box/data/models/replies_model.dart';
import 'package:all_star_learning/new/features/complain_box/data/models/role_user_model.dart';

import 'package:all_star_learning/new/features/complain_box/domain/entities/complain_entity.dart';

import 'package:dartz/dartz.dart';

import '../data_source/remote/complain_box_remote_data_source.dart';
import '../../domain/repository/complain_box_repository.dart';

class ComplainBoxRepositoryImpl implements IComplainBoxRepository {
  final ComplainBoxRemoteDataSource remoteDataSource;

  ComplainBoxRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<AppErrorHandler, ComplainEntity>> createComplain(
      {required int roleId,
      required String title,
      required String description,
      required List<int> complainToIds}) async {
    return await remoteDataSource.createComplain(
        roleId: roleId,
        title: title,
        description: description,
        complainToIds: complainToIds);
  }

  @override
  Future<Either<AppErrorHandler, List<ComplainEntity>>> getComplains() async {
    return await remoteDataSource.getComplains();
  }

  @override
  Future<Either<AppErrorHandler, ComplainEntity>> getSingleComplaint(
      {required int complainId}) async {
    return await remoteDataSource.getSingleComplaint(complainId: complainId);
  }

  @override
  Future<Either<AppErrorHandler, ComplainEntity>> updateComplain(
      {required int complainId,
      required int? roleId,
      required String? title,
      required String? description,
      required List<int>? complainToIds}) async {
    return await remoteDataSource.updateComplain(
        complainId: complainId,
        roleId: roleId,
        title: title,
        description: description,
        complainToIds: complainToIds);
  }

  @override
  Future<Either<AppErrorHandler, List<RoleUserModel>>> getRoleList() async {
    return await remoteDataSource.getRoleList();
  }

  @override
  Future<Either<AppErrorHandler, List<RoleUserModel>>> getRoleUsers(
      {required int roleId}) async {
    return await remoteDataSource.getRoleUsers(roleId: roleId);
  }

  @override
  Future<Either<AppErrorHandler, bool>> deleteComplain(
      {required int complainId}) async {
    return await remoteDataSource.deleteComplain(complainId: complainId);
  }

  @override
  Future<Either<AppErrorHandler, RepliesModel>> createReply(
      {required int complainId, required String description}) async {
    return await remoteDataSource.createReply(
        complainId: complainId, description: description);
  }

  @override
  Future<Either<AppErrorHandler, RepliesModel>> deleteReply(
      {required int complainId}) async {
    return await remoteDataSource.deleteReply(complainId: complainId);
  }
}
