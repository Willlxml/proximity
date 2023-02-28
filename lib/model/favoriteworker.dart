class FavoriteWorker {
  FavoriteWorker({
    required this.id,
    required this.nama,
    required this.lokasi,
    required this.jabatan,
    required this.descJabatan,
    required this.keahlian,
    required this.descKeahlian,
    required this.sop,
    required this.gaji,
    required this.syarat,
    required this.kontak,
    required this.image,
    required this.category
  });

  int? id;
  String? nama;
  String? lokasi;
  String? jabatan;
  String? descJabatan;
  String? keahlian;
  String? descKeahlian;
  String? sop;
  String? gaji;
  String? syarat;
  String? kontak;
  String? image;
  int? category;

    factory FavoriteWorker.fromMap(Map<String, dynamic> json) => new FavoriteWorker(
        id: json['id'],
        nama: json['nama'],
        lokasi: json['lokasi'],
        jabatan: json['jabatan'],
        descJabatan: json['desc_jabatan'],
        keahlian: json['keahlian'],
        descKeahlian: json['desc_keahlian'],
        sop: json['sop'],
        gaji: json['gaji'],
        syarat: json['gaji'],
        kontak: json['kontak'],
        image: json['image'],
        category: json['category_id'],
      );
 
  Map<String, dynamic> toMap() {
    return {
      "nama": nama,
      "lokasi": lokasi,
      "jabatan": jabatan,
      "desc_jabatan": descJabatan,
      "keahlian": keahlian,
      "desc_keahlian": descKeahlian,
      "sop" : sop,
      "gaji" : gaji,
      "syarat" : syarat,
      "kontak": kontak,
      "image": image,
      "category_id": category
    };

  }

 

}
