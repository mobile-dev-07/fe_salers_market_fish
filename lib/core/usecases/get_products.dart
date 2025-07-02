import 'package:dartz/dartz.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/errors/failures.dart';
import '../../components/auth/domain/entities/product_entity.dart';
import '../../components/auth/domain/repositories/product_repository.dart';

class GetProducts implements UseCase<List<ProductEntity>, NoParams> {
  final ProductRepository repository;

  GetProducts(this.repository);

  @override
  Future<Either<Failure, List<ProductEntity>>> call(NoParams params) async {
    return await repository.getProducts();
  }
}