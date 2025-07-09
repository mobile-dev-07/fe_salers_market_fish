part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class FetchProducts extends ProductEvent {}

class RegisterProductEvent extends ProductEvent {
  final String title;
  final String description;
  final String price;
  final String stock;
  final String weight;
  final File image;

  const RegisterProductEvent({
    required this.title,
    required this.description,
    required this.price,
    required this.stock,
    required this.weight,
    required this.image,
  });

  @override
  List<Object> get props => [title, description, price, stock, weight, image];
}