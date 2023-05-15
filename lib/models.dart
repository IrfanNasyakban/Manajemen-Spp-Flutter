class Siswa {
  String nama;
  String email;
  String nis;
  String ttl;
  String alamat;
  String id;

  Siswa({
    required this.nama,
    required this.email,
    required this.nis,
    required this.ttl,
    required this.alamat,
    required this.id,
  });

  factory Siswa.fromJson(Map<String, dynamic> json) {
    return Siswa(
      nama: json['nama'],
      email: json['email'],
      nis: json['nis'],
      ttl: json['ttl'],
      alamat: json['alamat'],
      id: json['id'],
    );
  }
}