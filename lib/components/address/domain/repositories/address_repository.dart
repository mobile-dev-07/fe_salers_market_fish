import '../../../../core/errors/failures.dart';
import 'package:dartz/dartz.dart';

import '../entities/address_entity.dart';
import '../entities/address_request_entity.dart';

abstract class AddressRepository {
  Future<Either<Failure, List<AddressEntity>>> getAddresses();
  Future<Either<Failure, AddressEntity>> addAddress(AddressRequestEntity address);
  Future<Either<Failure, void>> deleteAddress(String id);
}