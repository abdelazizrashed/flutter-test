import 'package:dio/dio.dart';
import 'package:evaluation_project/domain/models/home/home_model.dart';
import 'package:evaluation_project/domain/remote/dio.dart';
import 'package:evaluation_project/domain/remote/endpoints.dart';
import 'package:evaluation_project/logic/repositories/home/home_repository.dart';
import 'package:flutter/material.dart';

class HomeRepositoryImplementation implements HomeRepository {
  @override
  Future<HomeModel?> getData(
      {required Function(String message) onError}) async {
    try {
      final res = await DioHelper.postData(
        path: homeEndpoint,
        data: {
          "category_id": 1,
        },
      );
      final model = HomeModel.fromJson(res.data);
      if (model.data == null) {
        onError.call(model.message);
        return null;
      }
      return model;
    } catch (e, t) {
      debugPrint(e.toString());
      debugPrint(t.toString());
      if (e is DioError) {
        onError.call(e.response?.data['message'] ?? "Something went wrong!");
        return null;
      }
      onError.call("Something went wrong!");
      return null;
    }
  }
}
