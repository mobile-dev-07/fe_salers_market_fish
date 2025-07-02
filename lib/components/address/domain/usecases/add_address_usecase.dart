import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/address_entity.dart';
import '../entities/address_request_entity.dart';
import '../repositories/address_repository.dart';

class AddAddress implements UseCase<AddressEntity, AddressRequestEntity> {
  final AddressRepository repository;

  AddAddress(this.repository);

  @override
  Future<Either<Failure, AddressEntity>> call(AddressRequestEntity params) async {
    return await repository.addAddress(params);
  }
}