import 'package:all_star_learning/new/core/errors/error_handler.dart';
import 'package:all_star_learning/new/core/networks/api/dio_http_service.dart';
import 'package:all_star_learning/new/features/complain_box/data/models/complain_model.dart';
import 'package:all_star_learning/new/features/complain_box/data/models/replies_model.dart';
import 'package:all_star_learning/new/features/complain_box/data/models/role_user_model.dart';
import 'package:dartz/dartz.dart';

class ComplainBoxRemoteDataSource {
  final DioHttpService api;

  ComplainBoxRemoteDataSource({
    required this.api,
  });

  Future<Either<AppErrorHandler, List<ComplainModel>>> getComplains() async {
    try {
      final response = await api.handleGetRequest(
        path: "/complains",
      );
      if (response.statusCode == 200) {
        return Right(ComplainModel.fromListMap(response.data['data']));
      } else {
        if (response.data['message'] == null) {
          return Left(AppErrorHandler(message: "Something went wrong"));
        }
        return Left(AppErrorHandler(message: response.data['message']));
      }
    } catch (e) {
      return Left(AppErrorHandler(message: e.toString()));
    }
  }

  Future<Either<AppErrorHandler, ComplainModel>> createComplain({
    required int roleId,
    required String title,
    required String description,
    required List<int> complainToIds,
  }) async {
    try {
      final response = await api.handlePostRequest(
        path: "/complains",
        data: {
          "role_id": roleId,
          "title": title,
          "description": description,
          "user_ids": complainToIds,
        },
      );
      if (response.statusCode == 200) {
        return Right(ComplainModel.fromMap(response.data['data']));
      } else {
        if (response.data['message'] == null) {
          return Left(AppErrorHandler(message: "Something went wrong"));
        }
        return Left(AppErrorHandler(message: response.data['message']));
      }
    } catch (e) {
      return Left(AppErrorHandler(message: e.toString()));
    }
  }

  Future<Either<AppErrorHandler, ComplainModel>> updateComplain({
    required int complainId,
    int? roleId,
    String? title,
    String? description,
    List<int>? complainToIds,
  }) async {
    try {
      final response = await api.handlePutRequest(
        path: "/complains/$complainId",
        data: {
          "role_id": roleId,
          "title": title,
          "description": description,
          "user_ids": complainToIds,
        },
      );
      if (response.statusCode == 200) {
        return Right(ComplainModel.fromMap(response.data['data']));
      } else {
        if (response.data['message'] == null) {
          return Left(AppErrorHandler(message: "Something went wrong"));
        }
        return Left(AppErrorHandler(message: response.data['message']));
      }
    } catch (e) {
      return Left(AppErrorHandler(message: e.toString()));
    }
  }

  Future<Either<AppErrorHandler, ComplainModel>> getSingleComplaint({
    required int complainId,
  }) async {
    try {
      final response = await api.handleGetRequest(
        path: "/complains/$complainId",
      );
      if (response.statusCode == 200) {
        return Right(ComplainModel.fromMap(response.data['data']));
      } else {
        if (response.data['message'] == null) {
          return Left(AppErrorHandler(message: "Something went wrong"));
        }
        return Left(AppErrorHandler(message: response.data['message']));
      }
    } catch (e) {
      return Left(AppErrorHandler(message: e.toString()));
    }
  }

  Future<Either<AppErrorHandler, List<RoleUserModel>>> getRoleUsers({
    required int roleId,
  }) async {
    try {
      final response = await api.handleGetRequest(
        path: "/user-list",
        queryParameters: {"role_id": roleId},
      );
      if (response.statusCode == 200) {
        return Right(RoleUserModel.fromListMap(response.data['data']));
      } else {
        if (response.data['message'] == null) {
          return Left(AppErrorHandler(message: "Something went wrong"));
        }
        return Left(AppErrorHandler(message: response.data['message']));
      }
    } catch (e) {
      return Left(AppErrorHandler(message: e.toString()));
    }
  }

  Future<Either<AppErrorHandler, List<RoleUserModel>>> getRoleList() async {
    try {
      final response = await api.handleGetRequest(
        path: "/role-list",
      );
      if (response.statusCode == 200) {
        return Right(RoleUserModel.fromListMap(response.data['data']));
      } else {
        if (response.data['message'] == null) {
          return Left(AppErrorHandler(message: "Something went wrong"));
        }
        return Left(AppErrorHandler(message: response.data['message']));
      }
    } catch (e) {
      return Left(AppErrorHandler(message: e.toString()));
    }
  }

  Future<Either<AppErrorHandler, bool>> deleteComplain({
    required int complainId,
  }) async {
    try {
      final response = await api.handleDeleteRequest(
        path: "/complains/$complainId",
      );
      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        if (response.data['message'] == null) {
          return Left(AppErrorHandler(message: "Something went wrong"));
        }
        return Left(AppErrorHandler(message: response.data['message']));
      }
    } catch (e) {
      return Left(AppErrorHandler(message: e.toString()));
    }
  }

  Future<Either<AppErrorHandler, RepliesModel>> createReply({
    required int complainId,
    required String description,
  }) async {
    try {
      final response = await api.handlePostRequest(
        path: "complain-reply/store",
        data: {
          "complain_id": complainId,
          "description": description,
        },
      );
      if (response.statusCode == 200) {
        return Right(RepliesModel.fromMap(response.data['data']));
      } else {
        if (response.data['message'] == null) {
          return Left(AppErrorHandler(message: "Something went wrong"));
        }
        return Left(AppErrorHandler(message: response.data['message']));
      }
    } catch (e) {
      return Left(AppErrorHandler(message: e.toString()));
    }
  }

  Future<Either<AppErrorHandler, RepliesModel>> deleteReply({
    required int complainId,
  }) async {
    try {
      final response = await api.handleGetRequest(
        path: "complain-reply/$complainId",
      );
      if (response.statusCode == 200) {
        return Right(RepliesModel.fromMap(response.data['data']));
      } else {
        if (response.data['message'] == null) {
          return Left(AppErrorHandler(message: "Something went wrong"));
        }
        return Left(AppErrorHandler(message: response.data['message']));
      }
    } catch (e) {
      return Left(AppErrorHandler(message: e.toString()));
    }
  }
}
