import 'dart:io';

import 'package:dartz/dartz.dart';
import '../entities/product_entity.dart';
import '../../../../core/errors/failures.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<ProductEntity>>> getProducts();
  Future<Either<Failure, Map<String, dynamic>>> registerProduct({
    required String title,
    required String description,
    required String price,
    required String stock,
    required String weight,
    required File image,
  });
}