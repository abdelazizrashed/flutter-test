import 'package:dio/dio.dart';
import 'package:evaluation_project/domain/local/shared_prefs.dart';
import 'package:evaluation_project/domain/models/auth/auth_model.dart';
import 'package:evaluation_project/domain/remote/dio.dart';
import 'package:evaluation_project/domain/remote/endpoints.dart';
import 'package:evaluation_project/logic/repositories/auth/auth_repository.dart';
import 'package:flutter/foundation.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<AuthModel?> login(
    String phone,
    String pass, {
    required Function(String message) onError,
  }) async {
    try {
      final res = await DioHelper.postData(
        path: loginEndpoint,
        data: {
          "mobile": phone,
          "password": pass,
        },
      );
      final model = AuthModel.fromJson(res.data);
      if (model.data == null) {
        onError.call(model.message);
        return null;
      }
      saveName(model.data?.name ?? "");
      saveEmail(model.data?.email ?? "");
      saveImage(model.data?.image ?? "");
      saveMobile(model.data?.mobile ?? "");
      saveUserId(model.data?.id ?? 0);
      saveUserToken(model.data?.token ?? '');
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

  @override
  Future<AuthModel?> register(
    String name,
    String phone,
    String email,
    String pass,
    String confirmPass, {
    required Function(String message) onError,
  }) async {
    try {
      final res = await DioHelper.postData(
        path: registerEndpoint,
        data: {
          "name": name,
          "mobile": phone,
          "email": email,
          "password": pass,
          "password_confirmation": confirmPass,
        },
      );
      final model = AuthModel.fromJson(res.data);
      if (model.data == null) {
        onError.call(model.message);
        return null;
      }
      saveEmail(model.data?.email ?? "");
      saveImage(model.data?.image ?? "");
      saveMobile(model.data?.mobile ?? "");
      saveUserId(model.data?.id ?? 0);
      saveUserToken(model.data?.token ?? '');
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

  @override
  Future<bool> logout() async {
    return await removeUserToken();
  }

  @override
  bool isLoggedIn() {
    return getUserToken() != null && getUserToken()!.isNotEmpty;
  }
}
