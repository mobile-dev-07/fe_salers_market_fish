class AddressRequestEntity {
  final String title;
  final String address;
  final String contact;
  final double latitude;
  final double longitude;
  final bool active;
  final String? tag;

  AddressRequestEntity({
    required this.title,
    required this.address,
    required this.contact,
    required this.latitude,
    required this.longitude,
    required this.active,
    this.tag,
  });
}