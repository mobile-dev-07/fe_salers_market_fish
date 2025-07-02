class AddressEntity {
  final String id;
  final String title;
  final String address;
  final String tag;
  final String contact;
  final double latitude;
  final double longitudes;
  final bool active;

  AddressEntity({
    required this.id,
    required this.title,
    required this.address,
    required this.tag,
    required this.contact,
    required this.latitude,
    required this.longitudes,
    required this.active,
  });
}