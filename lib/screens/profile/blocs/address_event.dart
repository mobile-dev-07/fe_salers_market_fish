part of 'address_bloc.dart';


abstract class AddressEvent extends Equatable {
  const AddressEvent();

  @override
  List<Object> get props => [];
}

class LoadAddresses extends AddressEvent {}

class AddNewAddress extends AddressEvent {
  final AddressRequestEntity address;

  const AddNewAddress(this.address);

  @override
  List<Object> get props => [address];
}