// Model data Mahasiswa untuk penyimpanan database
class Mahasiswa {
  final int? id;
  final String nim;
  final String nama;
  final String prodi;
  final String jeniskelamin;
  String alamat;
  String tanggallahir;

  // Konstruktor Mahasiswa
  Mahasiswa({
    this.id,
    required this.nim,
    required this.nama,
    required this.prodi,
    required this.jeniskelamin,
    required this.alamat,
    required this.tanggallahir,
  });

  // Konversi objek ke Map untuk database
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nim': nim,
      'nama': nama,
      'prodi': prodi,
      'jeniskelamin': jeniskelamin,
      'alamat': alamat,
      'tanggallahir': tanggallahir,
    };
  }

  // Buat objek Mahasiswa dari Map hasil query database
  factory Mahasiswa.fromMap(Map<String, dynamic> map) {
    return Mahasiswa(
      id: map['id'],
      nim: map['nim'],
      nama: map['nama'],
      prodi: map['prodi'] ?? '',
      jeniskelamin: map['jeniskelamin'] ?? '', 
      alamat: map['alamat'] ?? '',
      tanggallahir: map['tanggallahir'] ?? '',
    );
  }
}
