class Favorite {
  Favorite({
    required this.id,
    required this.namaLengkap,
    required this.lokasi,
    required this.jabatan,
    required this.descJabatan,
    required this.keahlian,
    required this.descKeahlian,
    required this.pendidikanTerakhir,
    required this.pengalamanKerja,
    required this.kontak,
    required this.image,
  });

  int? id;
  String? namaLengkap;
  String? lokasi;
  String? jabatan;
  String? descJabatan;
  String? keahlian;
  String? descKeahlian;
  int? pendidikanTerakhir;
  String? pengalamanKerja;
  String? kontak;
  String? image;

    factory Favorite.fromMap(Map<String, dynamic> json) => new Favorite(
        id: json['id'],
        namaLengkap: json['nama_lengkap'],
        lokasi: json['lokasi'],
        jabatan: json['jabatan'],
        descJabatan: json['desc_jabatan'],
        keahlian: json['keahlian'],
        descKeahlian: json['desc_keahlian'],
        pendidikanTerakhir: json['pendidikan_terakhir'],
        pengalamanKerja: json['pengalaman_kerja'],
        kontak: json['kontak'],
        image: json['image'],
      );
 
  Map<String, dynamic> toMap() {
    return {
      "nama_lengkap": namaLengkap,
      "lokasi": lokasi,
      "jabatan": jabatan,
      "desc_jabatan": descJabatan,
      "keahlian": keahlian,
      "desc_keahlian": descKeahlian,
      "pendidikan_terakhir": pendidikanTerakhir,
      "pengalaman_kerja": pengalamanKerja,
      "kontak": kontak,
      "image": image,
    };

  }

 

}
