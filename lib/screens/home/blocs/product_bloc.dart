import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../components/auth/domain/entities/product_entity.dart';
import '../../../core/usecases/get_products.dart';
import '../../../core/usecases/register_product.dart';
import '../../../core/usecases/usecase.dart';


part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProducts getProducts;
  final RegisterProduct registerProduct;

  ProductBloc({required this.getProducts, required this.registerProduct}) : super(ProductInitial()) {
    on<FetchProducts>(_onFetchProducts);
    on<RegisterProductEvent>(_onRegisterProduct);
  }

  Future<void> _onFetchProducts(FetchProducts event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    final result = await getProducts(NoParams());

    result.fold(
          (failure) => emit(ProductError(failure.message)),
          (products) => emit(ProductLoaded(products)),
    );
  }
  Future<void> _onRegisterProduct(RegisterProductEvent event, Emitter<ProductState> emit) async {
    emit(ProductLoading()); // You might want a specific state like ProductRegistering
    final failureOrProduct = await registerProduct(
      ProductParams(
        title: event.title,
        description: event.description,
        price: event.price,
        stock: event.stock,
        weight: event.weight,
        image: event.image,
      ),
    );
    failureOrProduct.fold(
          (failure) => emit(ProductRegistrationFailure(message: failure.message)),
          (productData) => emit(ProductRegistrationSuccess(productData: productData)),
    );
  }
}