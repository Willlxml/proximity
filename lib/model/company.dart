// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'dart:convert';

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));

String categoryToJson(Category data) => json.encode(data.toJson());

class Category {
    Category({
        required this.data,
    });

    List<Datas> data;

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        data: List<Datas>.from(json["data"].map((x) => Datas.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datas {
    Datas({
        required this.id,
        required this.nama,
        required this.lokasi,
        required this.jabatan,
        required this.descJabatan,
        required this.keahlian,
        required this.descKeahlian,
        required this.syarat,
        required this.gaji,
        required this.sop,
        required this.kontak,
        required this.image,
        required this.categoryId,
    });

    int id;
    String nama;
    String lokasi;
    String jabatan;
    String descJabatan;
    String keahlian;
    String descKeahlian;
    String syarat;
    String gaji;
    String sop;
    String kontak;
    String image;
    int categoryId;

    factory Datas.fromJson(Map<String, dynamic> json) => Datas(
        id: json["id"],
        nama: json["nama"],
        lokasi: json["lokasi"],
        jabatan: json["jabatan"],
        descJabatan: json["desc_jabatan"],
        keahlian: json["keahlian"],
        descKeahlian: json["desc_keahlian"],
        syarat: json["syarat"],
        gaji: json["gaji"],
        sop: json["sop"],
        kontak: json["kontak"],
        image: json["image"],
        categoryId: json["category_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "lokasi": lokasi,
        "jabatan": jabatan,
        "desc_jabatan": descJabatan,
        "keahlian": keahlian,
        "desc_keahlian": descKeahlian,
        "syarat": syarat,
        "gaji": gaji,
        "sop": sop,
        "kontak": kontak,
        "image": image,
        "category_id": categoryId,
    };
}
