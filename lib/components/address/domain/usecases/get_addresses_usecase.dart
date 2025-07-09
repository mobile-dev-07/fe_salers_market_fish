  import '../../../../core/errors/failures.dart';
  import '../../../../core/usecases/usecase.dart';
  import 'package:dartz/dartz.dart';

  import '../entities/address_entity.dart';
  import '../repositories/address_repository.dart';

  class GetAddresses implements UseCase<List<AddressEntity>, NoParams> {
    final AddressRepository repository;

    GetAddresses(this.repository);

    @override
    Future<Either<Failure, List<AddressEntity>>> call(NoParams params) async {
      return await repository.getAddresses();
    }
  }