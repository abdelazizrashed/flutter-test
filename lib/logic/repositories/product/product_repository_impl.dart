import 'package:dio/dio.dart';
import 'package:evaluation_project/domain/models/product/product_model.dart';
import 'package:evaluation_project/domain/remote/dio.dart';
import 'package:evaluation_project/domain/remote/endpoints.dart';
import 'package:evaluation_project/logic/repositories/product/product_repository.dart';
import 'package:flutter/foundation.dart';

class ProductRepositoryImplementation implements ProductRepository {
  @override
  Future<ProductModel?> getProduct(
    int id, {
    required Function(String meeeage) onError,
  }) async {
    try {
      final res = await DioHelper.postData(
        path: productEndpoint,
        data: {
          "product_id": id,
        },
      );
      final model = ProductModel.fromJson(res.data);
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
