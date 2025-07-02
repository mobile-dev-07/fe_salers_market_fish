import 'package:dartz/dartz.dart';
import '../entities/auth_entity.dart';
import '../../../../core/errors/failures.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthEntity>> login(String email, String password);
  Future<Either<Failure, AuthEntity>> register({
    required String name,
    required String email,
    required String phoneNumber,
    required String password,
    int roleId = 2,
  });
  Future<Either<Failure, void>> logout();
}