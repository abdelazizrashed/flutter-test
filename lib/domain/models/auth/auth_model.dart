import 'package:equatable/equatable.dart';

class AuthModel extends Equatable {
  final bool success;
  final String message;
  final AuthDataModel? data;
  const AuthModel({
    required this.success,
    required this.message,
    required this.data,
  });

  AuthModel copyWith({
    bool? success,
    String? message,
    AuthDataModel? data,
  }) {
    return AuthModel(
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

  factory AuthModel.fromJson(Map<String, dynamic> map) {
    return AuthModel(
      success: map['success'] as bool,
      message: map['message'] as String,
      data: AuthDataModel.fromJson(map['data'] as Map<String, dynamic>),
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [success, message, data ?? ''];
}

class AuthDataModel extends Equatable {
  final int id;
  final String name;
  final String mobile;
  final String email;
  final String image;
  final String token;
  const AuthDataModel({
    required this.id,
    required this.name,
    required this.mobile,
    required this.email,
    required this.image,
    required this.token,
  });

  AuthDataModel copyWith({
    int? id,
    String? name,
    String? mobile,
    String? email,
    String? image,
    String? token,
  }) {
    return AuthDataModel(
      id: id ?? this.id,
      name: name ?? this.name,
      mobile: mobile ?? this.mobile,
      email: email ?? this.email,
      image: image ?? this.image,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'mobile': mobile,
      'email': email,
      'image': image,
      'token': token,
    };
  }

  factory AuthDataModel.fromJson(Map<String, dynamic> map) {
    return AuthDataModel(
      id: map['id'] as int,
      name: map['name'] as String,
      mobile: map['mobile'] as String,
      email: map['email'] as String,
      image: map['image'] as String,
      token: map['token'] as String,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      name,
      mobile,
      email,
      image,
      token,
    ];
  }
}
