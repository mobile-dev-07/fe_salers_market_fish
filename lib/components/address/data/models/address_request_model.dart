import '../../domain/entities/address_request_entity.dart';

class AddressRequestModel extends AddressRequestEntity {
  AddressRequestModel({
    required String title,
    required String address,
    required String contact,
    required double latitude,
    required double longitude,
    required bool active,
    String? tag,
  }) : super(
    title: title,
    address: address,
    contact: contact,
    latitude: latitude,
    longitude: longitude,
    active: active,
    tag: tag,
  );

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'address': address,
      'contact': contact,
      'latitude': latitude,
      'longitude': longitude,
      'active': active,
      if (tag != null) 'tag': tag,
    };
  }
}