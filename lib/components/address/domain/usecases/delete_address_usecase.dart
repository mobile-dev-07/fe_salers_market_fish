import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart'; // Pastikan Usecase diimpor
import '../repositories/address_repository.dart';

class DeleteAddress implements UseCase<void, String> { // void untuk sukses, String untuk ID
  final AddressRepository repository;

  DeleteAddress(this.repository);

  @override
  Future<Either<Failure, void>> call(String id) async {
    return await repository.deleteAddress(id);
  }
}