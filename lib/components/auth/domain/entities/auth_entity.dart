class AuthEntity {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final int roleId;
  final String token;

  AuthEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.roleId,
    required this.token,
  });
}