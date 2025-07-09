part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<ProductEntity> products;

  const ProductLoaded(this.products);

  @override
  List<Object> get props => [products];
}

class ProductError extends ProductState {
  final String message;

  const ProductError(this.message);

  @override
  List<Object> get props => [message];
}

class ProductRegistrationSuccess extends ProductState {
  final Map<String, dynamic> productData;

  const ProductRegistrationSuccess({required this.productData});

  @override
  List<Object> get props => [productData];
}

class ProductRegistrationFailure extends ProductState {
  final String message;

  const ProductRegistrationFailure({required this.message});

  @override
  List<Object> get props => [message];
}