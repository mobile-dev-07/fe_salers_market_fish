import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../components/auth/domain/entities/product_entity.dart';
import '../../../core/usecases/get_products.dart';
import '../../../core/usecases/usecase.dart';


part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProducts getProducts;

  ProductBloc({required this.getProducts}) : super(ProductInitial()) {
    on<FetchProducts>(_onFetchProducts);
  }

  Future<void> _onFetchProducts(FetchProducts event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    final result = await getProducts(NoParams());

    result.fold(
          (failure) => emit(ProductError(failure.message)),
          (products) => emit(ProductLoaded(products)),
    );
  }
}