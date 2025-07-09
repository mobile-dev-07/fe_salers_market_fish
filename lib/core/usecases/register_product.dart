import 'dart:io';

import 'package:dartz/dartz.dart';
import '../../components/auth/domain/repositories/product_repository.dart';
import '../errors/failures.dart';
import '../usecases/usecase.dart';

class RegisterProduct implements UseCase<Map<String, dynamic>, ProductParams> {
  final ProductRepository repository;

  RegisterProduct(this.repository);

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(ProductParams params) async {
    return await repository.registerProduct(
      title: params.title,
      description: params.description,
      price: params.price,
      stock: params.stock,
      weight: params.weight,
      image: params.image,
    );
  }
}

class ProductParams {
  final String title;
  final String description;
  final String price;
  final String stock;
  final String weight;
  final File image;

  ProductParams({
    required this.title,
    required this.description,
    required this.price,
    required this.stock,
    required this.weight,
    required this.image,
  });
}