import 'package:evaluation_project/domain/models/product/product_model.dart';
import 'package:evaluation_project/service_locator.dart';

abstract class ProductRepository {
  static ProductRepository get() => getIt.get<ProductRepository>();

  Future<ProductModel?> getProduct(
    int id, {
    required Function(String meeeage) onError,
  });
}
