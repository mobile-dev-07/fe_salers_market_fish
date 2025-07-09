import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/address_entity.dart';
import '../../domain/entities/address_request_entity.dart';
import '../../domain/repositories/address_repository.dart';
import '../datasources/address_remote_data_source.dart';
import 'package:dartz/dartz.dart';

class AddressRepositoryImpl implements AddressRepository {
  final AddressRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  AddressRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<AddressEntity>>> getAddresses() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteAddresses = await remoteDataSource.getAddresses();
        return Right(remoteAddresses);
      } on ServerException {
        return Left(ServerFailure('Server failure'));
      }
    } else {
      return Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, AddressEntity>> addAddress(AddressRequestEntity address) async {
    if (await networkInfo.isConnected) {
      try {
        final addedAddress = await remoteDataSource.addAddress(address);
        return Right(addedAddress);
      } on ServerException {
        return Left(ServerFailure('Failed to add address'));
      }
    } else {
      return Left(NetworkFailure('No internet connection'));
    }
  }
  @override
  Future<Either<Failure, void>> deleteAddress(String id) async { // --- TAMBAHKAN IMPLEMENTASI INI ---
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.deleteAddress(id);
        return const Right(null); // Return Right(null) for void success
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return Left(NetworkFailure('No internet connection'));
    }
  }
}