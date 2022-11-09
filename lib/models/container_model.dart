class ContainerModel {
  int id;
  String address;
  double latitude;
  double longitude;
  int status;

  ContainerModel({
    required this.id,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.status
});

  factory ContainerModel.fromJson(Map<String, dynamic> json) {
    return ContainerModel(
        id: json["id"] as int,
        address: json["address"] as String,
        latitude: json["latitude"] as double,
        longitude: json["longitude"] as double,
        status: json["status"] as int);
  }
}