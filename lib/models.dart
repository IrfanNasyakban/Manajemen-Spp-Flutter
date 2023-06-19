class Siswa {
  String nama;
  String email;
  String kelas;
  String semester;
  String nis;
  String ttl;
  String alamat;
  String wali_kelas;
  String ayah;
  String pekerjaan_ayah;
  String ibu;
  String pekerjaan_ibu;
  String no_hp;
  String image;
  String url;
  String createdAt;
  String updatedAt;
  int id;

  Siswa({
    required this.nama,
    required this.email,
    required this.kelas,
    required this.semester,
    required this.nis,
    required this.ttl,
    required this.alamat,
    required this.wali_kelas,
    required this.ayah,
    required this.pekerjaan_ayah,
    required this.ibu,
    required this.pekerjaan_ibu,
    required this.no_hp,
    required this.image,
    required this.url,
    required this.createdAt,
    required this.updatedAt,
    required this.id,
  });

  factory Siswa.fromJson(Map<String, dynamic> json) {
    return Siswa(
      nama: json['nama'],
      email: json['email'],
      kelas: json['kelas'],
      semester: json['semester'],
      nis: json['nis'],
      ttl: json['ttl'],
      alamat: json['alamat'],
      wali_kelas: json['wali_kelas'],
      ayah: json['ayah'],
      pekerjaan_ayah: json['pekerjaan_ayah'],
      ibu: json['ibu'],
      pekerjaan_ibu: json['pekerjaan_ibu'],
      no_hp: json['no_hp'],
      image: json['image'],
      url: json['url'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      id: json['id'],
    );
  }
}

class Bayar {
  String nama;
  String kelas;
  String semester;
  String jumlah;
  String status;
  String image;
  String createdAt;
  int id;

  Bayar({
    required this.nama,
    required this.kelas,
    required this.semester,
    required this.jumlah,
    required this.status,
    required this.image,
    required this.createdAt,
    required this.id,
  });

  factory Bayar.fromJson(Map<String, dynamic> json) {
    return Bayar(
      nama: json['nama'],
      kelas: json['kelas'],
      semester: json['semester'],
      jumlah: json['jumlah'],
      status: json['status'],
      image: json['image'],
      createdAt: json['createdAt'],
      id: json['id'],
    );
  }
}
