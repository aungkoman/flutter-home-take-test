class ShopEntity {
  int id;
  String name;
  String description;
  String address;
  String imageUrl;
  double lat;
  double lng;

  ShopEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.address,
    required this.imageUrl,
    required this.lat,
    required this.lng,
  });
}
