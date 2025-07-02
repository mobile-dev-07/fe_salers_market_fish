import 'package:dartz/dartz.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/errors/failures.dart';
import '../entities/auth_entity.dart';
import '../repositories/auth_repository.dart';

class RegisterUseCase implements UseCase<AuthEntity, RegisterParams> {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  @override
  Future<Either<Failure, AuthEntity>> call(RegisterParams params) async {
    return await repository.register(
      name: params.name,
      email: params.email,
      phoneNumber: params.phoneNumber,
      password: params.password,
    );
  }
}

class RegisterParams {
  final String name;
  final String email;
  final String phoneNumber;
  final String password;
  final int roleId;

  RegisterParams({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.password,
    this.roleId = 2,
  });
}