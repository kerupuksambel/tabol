class Order {
  final int id;
  final String tenantName;
  final int serviceId;
  final String status;
  final double lat;
  final double long;
  final String createdAt;
  final String updatedAt;

  Order({
    required this.id,
    required this.tenantName,
    required this.serviceId,
    required this.status,
    required this.lat,
    required this.long,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) {

    return Order(
      tenantName: json['tenant_nama'],
      id: json['id'],
      serviceId: json['service_id'],
      status: json['status'],
      lat: json['lat'],
      long: json['long'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}