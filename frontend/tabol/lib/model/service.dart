import 'package:intl/intl.dart';

class Service {
  final int id;
  final int tenantId;
  final String nama;
  final int harga;
  final String hargaFormat;

  Service({
    required this.tenantId,
    required this.id,
    required this.nama,
    required this.harga,
    required this.hargaFormat
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    NumberFormat formatCurrency = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp. ',
      decimalDigits: 0
    );

    return Service(
      tenantId: json['id_tenant'],
      id: json['id'],
      nama: json['nama'],
      harga: json['harga'],
      hargaFormat: formatCurrency.format(json["harga"])
    );
  }
}