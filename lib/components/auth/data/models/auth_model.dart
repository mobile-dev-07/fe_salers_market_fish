import '../../domain/entities/auth_entity.dart';

class AuthModel {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final int roleId;
  final String token;

  AuthModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.roleId,
    required this.token,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      roleId: json['role_id'] != null ? int.tryParse(json['role_id'].toString()) ?? 2 : 2,
      token: json['token']  ?? '',
    );
  }

  AuthEntity toEntity() {
    return AuthEntity(
      id: id,
      name: name,
      email: email,
      phoneNumber: phoneNumber,
      roleId: roleId,
      token: token,
    );
  }
}