import 'package:dartz/dartz.dart';
import '../entities/product_entity.dart';
import '../../../../core/errors/failures.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<ProductEntity>>> getProducts();
}