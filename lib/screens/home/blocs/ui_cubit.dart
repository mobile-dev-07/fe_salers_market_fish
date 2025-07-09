// ui_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// Definisi State untuk UI
enum UiPage { products, addresses, profile, shopStatistics, registerProduct }

class UiState extends Equatable {
  final UiPage currentPage;

  const UiState({this.currentPage = UiPage.products});

  UiState copyWith({
    UiPage? currentPage,
  }) {
    return UiState(
      currentPage: currentPage ?? this.currentPage,
    );
  }

  @override
  List<Object> get props => [currentPage];
}

// Cubit untuk mengelola state UI
class UiCubit extends Cubit<UiState> {
  UiCubit() : super(const UiState());

  void navigateTo(UiPage page) {
    emit(state.copyWith(currentPage: page));
  }
}