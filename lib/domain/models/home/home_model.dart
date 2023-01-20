import 'package:equatable/equatable.dart';

class HomeModel extends Equatable {
  final bool success;
  final String message;
  final HomeDataModel? data;
  const HomeModel({
    required this.success,
    required this.message,
    required this.data,
  });

  HomeModel copyWith({
    bool? success,
    String? message,
    HomeDataModel? data,
  }) {
    return HomeModel(
      success: success ?? this.success,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'success': success,
      'message': message,
      'data': data?.toJson(),
    };
  }

  factory HomeModel.fromJson(Map<String, dynamic> map) {
    return HomeModel(
      success: map['success'] as bool,
      message: map['message'] as String,
      data: HomeDataModel.fromJson(map['data'] as Map<String, dynamic>),
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [success, message, data ?? ""];
}

class HomeDataModel extends Equatable {
  final int id;
  final String name;
  final List<HomeProductModel> product;
  const HomeDataModel({
    required this.id,
    required this.name,
    required this.product,
  });

  HomeDataModel copyWith({
    int? id,
    String? name,
    List<HomeProductModel>? product,
  }) {
    return HomeDataModel(
      id: id ?? this.id,
      name: name ?? this.name,
      product: product ?? this.product,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'product': product.map((x) => x.toJson()).toList(),
    };
  }

  factory HomeDataModel.fromJson(Map<String, dynamic> map) {
    return HomeDataModel(
      id: map['id'] as int,
      name: map['name'] as String,
      product: List<HomeProductModel>.from(
        (map['product'] as List<HomeProductModel>).map<HomeProductModel>(
          (x) => HomeProductModel.fromJson(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id, name, product];
}

class HomeProductModel extends Equatable {
  final int id;
  final String name;
  final String image;
  final int price;
  final int oldprice;
  const HomeProductModel({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.oldprice,
  });

  HomeProductModel copyWith({
    int? id,
    String? name,
    String? image,
    int? price,
    int? oldprice,
  }) {
    return HomeProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      price: price ?? this.price,
      oldprice: oldprice ?? this.oldprice,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'image': image,
      'price': price,
      'oldprice': oldprice,
    };
  }

  factory HomeProductModel.fromJson(Map<String, dynamic> map) {
    return HomeProductModel(
      id: map['id'] as int,
      name: map['name'] as String,
      image: map['image'] as String,
      price: map['price'] as int,
      oldprice: map['oldprice'] as int,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      name,
      image,
      price,
      oldprice,
    ];
  }
}
