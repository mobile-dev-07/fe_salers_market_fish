import 'package:dartz/dartz.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/secure_storage.dart';
import '../datasources/auth_remote_data_source.dart';
import '../../domain/entities/auth_entity.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, AuthEntity>> login(String email, String password) async {
    if (await networkInfo.isConnected) {
      try {
        final authModel = await remoteDataSource.login(email, password);
        await SecureStorage.saveToken(authModel.token); // Save token
        return Right(authModel.toEntity());
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, AuthEntity>> register({
    required String name,
    required String email,
    required String phoneNumber,
    required String password,
    int roleId = 2,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final authModel = await remoteDataSource.register(
          name: name,
          email: email,
          phoneNumber: phoneNumber,
          password: password,
        );
        return Right(authModel.toEntity());
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return Left(NetworkFailure('No internet connection'));
    }
  }
  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await SecureStorage.deleteToken(); // Hapus token dari storage
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure('Failed to logout'));
    }
  }
}