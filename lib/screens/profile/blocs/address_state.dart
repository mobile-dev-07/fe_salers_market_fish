part of 'address_bloc.dart';

enum AddressStatus { initial, loading, success, failure, addSuccess, deleteSuccess }

class AddressState extends Equatable {
  final AddressStatus status;
  final List<AddressEntity> addresses; // Ensure this is never null
  final String errorMessage;

  const AddressState({
    this.status = AddressStatus.initial,
    this.addresses = const [], // Crucial: default to an empty list, not null
    this.errorMessage = '',
  });

  AddressState copyWith({
    AddressStatus? status,
    List<AddressEntity>? addresses,
    String? errorMessage,
  }) {
    return AddressState(
      status: status ?? this.status,
      addresses: addresses ?? this.addresses, // Use existing list if new one is null
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  AddressState resetStatus() {
    return copyWith(
      status: AddressStatus.success,
      errorMessage: '',
    );
  }

  @override
  List<Object> get props => [status, addresses, errorMessage];
}