class Mahasiswa {
  final int? id;
  final String nim;
  final String nama;
  final String prodi;
  final String jeniskelamin;

  Mahasiswa({this.id, required this.nim, required this.nama, required this.prodi, required this.jeniskelamin});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nim': nim,
      'nama': nama,
      'prodi': prodi,
      'jeniskelamin': jeniskelamin,
    };
  }

  factory Mahasiswa.fromMap(Map<String, dynamic> map) {
    return Mahasiswa(
      id: map['id'],
      nim: map['nim'],
      nama: map['nama'],
      prodi: map['prodi'],
      jeniskelamin: map['jeniskelamin'],
    );
  }
}
