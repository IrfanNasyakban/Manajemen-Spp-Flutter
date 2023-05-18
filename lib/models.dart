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

class ImageData {
  String nama;
  String kelas;
  String semester;
  String jumlah;
  String bukti;
  String id;

  ImageData({
    required this.nama,
    required this.kelas,
    required this.semester,
    required this.jumlah,
    required this.bukti,
    required this.id,
  });

  factory ImageData.fromJson(Map<String, dynamic> json) {
    return ImageData(
      nama: json['nama'],
      kelas: json['kelas'],
      semester: json['semester'],
      jumlah: json['jumlah'],
      bukti: json['bukti'],
      id: json['id'],
    );
  }
}
