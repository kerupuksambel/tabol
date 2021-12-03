class Tenant {
  final int userId;
  final int id;
  final String nama;
  final String deskripsi;
  final String photoUrl;
  final double rating;

  Tenant({
    required this.userId,
    required this.id,
    required this.nama,
    required this.deskripsi,
    required this.photoUrl,
    required this.rating
  });

  factory Tenant.fromJson(Map<String, dynamic> json) {
    return Tenant(
      userId: json['user_id'],
      id: json['id'],
      nama: json['nama'],
      deskripsi: json['deskripsi'],
      photoUrl: json['photo_url'],
      rating: json['rating'],
    );
  }
}