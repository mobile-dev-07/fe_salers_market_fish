import '../../domain/entities/address_entity.dart';

class AddressModel extends AddressEntity {
  AddressModel({
    required String id,
    required String title,
    required String address,
    required String tag,
    required String contact,
    required double latitude,
    required double longitudes,
    required bool active,
  }) : super(
    id: id,
    title: title,
    address: address,
    tag: tag,
    contact: contact,
    latitude: latitude,
    longitudes: longitudes,
    active: active,
  );

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    try {
      return AddressModel(
        id: json['id']?.toString() ?? '', // Handle potential null
        title: json['title']?.toString() ?? '',
        address: json['address']?.toString() ?? '',
        tag: json['tag']?.toString() ?? '',
        contact: json['contact']?.toString() ?? '',
        latitude: (json['latitude'] as num?)?.toDouble() ?? 0.0,
        longitudes: (json['longitudes'] as num?)?.toDouble() ?? 0.0,
        active: json['active'] as bool? ?? false,
      );
    } catch (e) {
      throw FormatException('Failed to parse AddressModel: $e');
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'address': address,
      'tag': tag,
      'contact': contact,
      'latitude': latitude,
      'longitudes': longitudes,
      'active': active,
    };
  }
}