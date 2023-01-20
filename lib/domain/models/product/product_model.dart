// ignore_for_file: non_constant_identifier_names

import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  final bool success;
  final String message;
  final ProductDataModel? data;
  const ProductModel({
    required this.success,
    required this.message,
    required this.data,
  });

  ProductModel copyWith({
    bool? success,
    String? message,
    ProductDataModel? data,
  }) {
    return ProductModel(
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

  factory ProductModel.fromJson(Map<String, dynamic> map) {
    return ProductModel(
      success: map['success'] as bool,
      message: map['message'] as String,
      data: ProductDataModel.fromJson(map['data'] as Map<String, dynamic>),
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [success, message, data ?? ""];
}

class ProductDataModel extends Equatable {
  final int id;
  final String name;
  final String description;
  final String image;
  final int price;
  final List<ProductImageModel> MoreImage;
  final List<ProductColorModel> Color;
  const ProductDataModel({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.price,
    required this.MoreImage,
    required this.Color,
  });

  ProductDataModel copyWith({
    int? id,
    String? name,
    String? description,
    String? image,
    int? price,
    List<ProductImageModel>? MoreImage,
    List<ProductColorModel>? Color,
  }) {
    return ProductDataModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      image: image ?? this.image,
      price: price ?? this.price,
      MoreImage: MoreImage ?? this.MoreImage,
      Color: Color ?? this.Color,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'image': image,
      'price': price,
      'MoreImage': MoreImage.map((x) => x.toJson()).toList(),
      'Color': Color.map((x) => x.toJson()).toList(),
    };
  }

  factory ProductDataModel.fromJson(Map<String, dynamic> map) {
    return ProductDataModel(
      id: map['id'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
      image: map['image'] as String,
      price: map['price'] as int,
      MoreImage: List<ProductImageModel>.from(
        (map['MoreImage'] as List).map<ProductImageModel>(
          (x) => ProductImageModel.fromJson(x as Map<String, dynamic>),
        ),
      ),
      Color: List<ProductColorModel>.from(
        (map['Color'] as List).map<ProductColorModel>(
          (x) => ProductColorModel.fromJson(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      name,
      description,
      image,
      price,
      MoreImage,
      Color,
    ];
  }
}

class ProductColorModel extends Equatable {
  final int id;
  final String name;
  final String hex;
  final List<ProductSizeModel> Size;
  const ProductColorModel({
    required this.id,
    required this.name,
    required this.hex,
    required this.Size,
  });

  ProductColorModel copyWith({
    int? id,
    String? name,
    String? hex,
    List<ProductSizeModel>? Size,
  }) {
    return ProductColorModel(
      id: id ?? this.id,
      name: name ?? this.name,
      hex: hex ?? this.hex,
      Size: Size ?? this.Size,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'hex': hex,
      'Size': Size.map((x) => x.toJson()).toList(),
    };
  }

  factory ProductColorModel.fromJson(Map<String, dynamic> map) {
    return ProductColorModel(
      id: map['id'] as int,
      name: map['name'] as String,
      hex: map['hex'] as String,
      Size: List<ProductSizeModel>.from(
        (map['Size'] as List).map<ProductSizeModel>(
          (x) => ProductSizeModel.fromJson(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id, name, hex, Size];
}

class ProductSizeModel extends Equatable {
  final int id;
  final String name;
  const ProductSizeModel({
    required this.id,
    required this.name,
  });

  ProductSizeModel copyWith({
    int? id,
    String? name,
  }) {
    return ProductSizeModel(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory ProductSizeModel.fromJson(Map<String, dynamic> map) {
    return ProductSizeModel(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id, name];
}

class ProductImageModel extends Equatable {
  final int id;
  final String image;
  final String hex;
  const ProductImageModel({
    required this.id,
    required this.image,
    required this.hex,
  });

  ProductImageModel copyWith({
    int? id,
    String? image,
    String? hex,
  }) {
    return ProductImageModel(
      id: id ?? this.id,
      image: image ?? this.image,
      hex: hex ?? this.hex,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'image': image,
      'hex': hex,
    };
  }

  factory ProductImageModel.fromJson(Map<String, dynamic> map) {
    return ProductImageModel(
      id: map['id'] as int,
      image: map['image'] as String,
      hex: map['hex'] as String,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id, image, hex];
}
