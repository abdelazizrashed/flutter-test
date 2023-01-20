import 'package:evaluation_project/domain/models/home/home_model.dart';
import 'package:evaluation_project/service_locator.dart';

abstract class HomeRepository {
  static HomeRepository get() => getIt.get<HomeRepository>();

  Future<HomeModel?> getData({required Function(String? message) onError});
}
