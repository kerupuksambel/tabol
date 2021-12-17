import 'package:intl/intl.dart';

class Order {
  final int id;
  final String tenantName;
  final int serviceId;
  final String status;
  final double lat;
  final double long;
  final String createdAt;
  final String updatedAt;
  final int userId;
  
  String? serviceName;
  int? harga;
  String? hargaFormat;
  int? rating;

  Order({
    required this.id,
    required this.tenantName,
    required this.serviceId,
    required this.status,
    required this.lat,
    required this.long,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
  }
    // {
    //   this.serviceName = "",
    //   this.harga = 0,
    //   this.rating = 0
    // }
  );

  factory Order.fromJson(Map<String, dynamic> json) {
    NumberFormat formatCurrency = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp. ',
      decimalDigits: 0
    );
    
    Order order = Order(
      tenantName: json['tenant_nama'],
      id: json['id'],
      serviceId: json['service_id'],
      status: json['status'],
      lat: json['lat'],
      long: json['long'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      userId: json['user_id']
    );

    if(json.containsKey("service_nama")){
      order.serviceName = json['service_nama'];
    }

    if(json.containsKey('harga')){
      order.harga = json['harga'];
      order.hargaFormat = formatCurrency.format(json['harga']);
    }

    if(json.containsKey('rating')){
      order.rating = json['rating'];
    }

    return order;
  }
}