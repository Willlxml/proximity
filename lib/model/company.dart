import 'dart:io';

class Company {
  File? file, image;
  String? id, nama, location, jabatan, desc_jabatan, keahlian, desc_keahlian, gaji, sop, contact, category;

  Company({
    required this.file,
    required this. image,
    required this.id,
    required this.nama,
    required this.location,
    required this.jabatan,
    required this.desc_jabatan,
    required this.keahlian,
    required this.desc_keahlian,
    required this.gaji,
    required this.sop,
    required this.contact,
    required this.category,
  });
}