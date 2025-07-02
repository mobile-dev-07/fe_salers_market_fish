import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../components/address/domain/entities/address_entity.dart';
import '../../../components/address/domain/entities/address_request_entity.dart';
import '../../../components/address/domain/usecases/add_address_usecase.dart';
import '../../../components/address/domain/usecases/get_addresses_usecase.dart';
import '../../../core/usecases/usecase.dart';


part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  final GetAddresses getAddresses;
  final AddAddress addAddress;

  AddressBloc({
    required this.getAddresses,
    required this.addAddress,
  }) : super(const AddressState()) {
    on<LoadAddresses>(_onLoadAddresses);
    on<AddNewAddress>(_onAddNewAddress);
  }

  Future<void> _onLoadAddresses(
      LoadAddresses event,
      Emitter<AddressState> emit,
      ) async {
    emit(state.copyWith(status: AddressStatus.loading));

    final result = await getAddresses(NoParams());

    result.fold(
          (failure) => emit(state.copyWith(
        status: AddressStatus.failure,
        errorMessage: failure.message,
      )),
          (addresses) => emit(state.copyWith(
        status: AddressStatus.success,
        addresses: addresses,
      )),
    );
  }
  // In address_bloc.dart
  Future<void> _onAddNewAddress(
      AddNewAddress event,
      Emitter<AddressState> emit,
      ) async {
    emit(state.copyWith(status: AddressStatus.loading));

    final result = await addAddress(event.address);

    result.fold(
          (failure) => emit(state.copyWith(
        status: AddressStatus.failure,
        errorMessage: failure.message,
      )),
          (address) {
        // Create a new list with the added address
        final updatedAddresses = List<AddressEntity>.from(state.addresses)..add(address);
        emit(state.copyWith(
          status: AddressStatus.success, // Use success instead of addSuccess
          addresses: updatedAddresses,
        ));
      },
    );
  }
}