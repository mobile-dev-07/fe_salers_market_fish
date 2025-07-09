import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../components/address/domain/entities/address_entity.dart';
import '../../../components/address/domain/entities/address_request_entity.dart';
import '../../../components/address/domain/usecases/add_address_usecase.dart';
import '../../../components/address/domain/usecases/delete_address_usecase.dart';
import '../../../components/address/domain/usecases/get_addresses_usecase.dart';
import '../../../core/usecases/usecase.dart';


part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  final GetAddresses getAddresses;
  final AddAddress addAddress;
  final DeleteAddress deleteAddress;

  AddressBloc({
    required this.getAddresses,
    required this.addAddress,
    // required Object deleteAddress,
    required this.deleteAddress,
  }) : super(const AddressState()) {
    on<LoadAddresses>(_onLoadAddresses);
    on<AddNewAddress>(_onAddNewAddress);
    on<DeleteAddressEvent>(_onDeleteAddress);
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
          status: AddressStatus.addSuccess, // Menggunakan status addSuccess
          addresses: updatedAddresses,
        ));
        // Setelah berhasil menambahkan, Anda mungkin ingin memuat ulang daftar alamat
        // atau cukup perbarui state dengan alamat baru
        add(LoadAddresses()); // Muat ulang daftar alamat setelah penambahan
      },
    );
  }
  Future<void> _onDeleteAddress(
      DeleteAddressEvent event,
      Emitter<AddressState> emit,
      ) async {
    emit(state.copyWith(status: AddressStatus.loading)); // Opsi: bisa juga pakai status deleting

    final result = await deleteAddress(event.id); // Memanggil UseCase delete

    result.fold(
          (failure) => emit(state.copyWith(
        status: AddressStatus.failure, // Set ke failure jika gagal
        errorMessage: failure.message,
      )),
          (_) { // Untuk void, parameter sukses adalah _
        // Opsional: Lakukan optimistic update (hapus dari list lokal)
        // Jika Anda yakin API akan selalu berhasil dan ingin tampilan instan
        // final updatedAddresses = List<AddressEntity>.from(state.addresses)
        //   ..removeWhere((address) => address.id == event.id);

        emit(state.copyWith(
          status: AddressStatus.deleteSuccess, // Set status delete berhasil
          // addresses: updatedAddresses, // Opsional: gunakan updatedAddresses jika optimistic update aktif
        ));

        // --- INI BAGIAN PALING PENTING UNTUK REFRESH TAMPILAN ---
        // Setelah berhasil menghapus, muat ulang daftar alamat dari server.
        // Ini memastikan tampilan selalu sinkron dengan database.
        add(LoadAddresses());
      },
    );
  }
}