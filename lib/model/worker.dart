// To parse this JSON data, do
//
//     final workerrr = workerrrFromJson(jsonString);

import 'dart:convert';

Workerrr workerrrFromJson(String str) => Workerrr.fromJson(json.decode(str));

String workerrrToJson(Workerrr data) => json.encode(data.toJson());

class Workerrr {
    Workerrr({
        required this.data,
    });

    List<Datum> data;

    factory Workerrr.fromJson(Map<String, dynamic> json) => Workerrr(
        data: List<Datum>.from(json["Data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
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

    String id;
    String namaLengkap;
    String lokasi;
    String jabatan;
    String descJabatan;
    String keahlian;
    String descKeahlian;
    String pendidikanTerakhir;
    String pengalamanKerja;
    String kontak;
    String image;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        namaLengkap: json["nama_lengkap"],
        lokasi: json["lokasi"],
        jabatan: json["jabatan"],
        descJabatan: json["desc_jabatan"],
        keahlian: json["keahlian"],
        descKeahlian: json["desc_keahlian"],
        pendidikanTerakhir: json["pendidikan_terakhir"],
        pengalamanKerja: json["pengalaman_kerja"],
        kontak: json["kontak"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
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
