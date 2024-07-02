import 'dart:convert';

class Alatmusik {
  final String? id;
  final String nama;
  final String no_hp;
  final String instrumen;
  final String hari;
  final String durasi;
  final String opsi;
  final String alamat;
  final String pembayaran;
  final String total_harga;
  final String? status;
  Alatmusik({
    this.id,
    required this.nama,
    required this.no_hp,
    required this.instrumen,
    required this.hari,
    required this.durasi,
    required this.opsi,
    required this.alamat,
    required this.pembayaran,
    required this.total_harga,
    this.status,
  });

  Alatmusik copyWith({
    String? id,
    String? nama,
    String? no_hp,
    String? instrumen,
    String? hari,
    String? durasi,
    String? opsi,
    String? alamat,
    String? pembayaran,
    String? total_harga,
    String? status,
  }) {
    return Alatmusik(
      id: id ?? this.id,
      nama: nama ?? this.nama,
      no_hp: no_hp ?? this.no_hp,
      instrumen: instrumen ?? this.instrumen,
      hari: hari ?? this.hari,
      durasi: durasi ?? this.durasi,
      opsi: opsi ?? this.opsi,
      alamat: alamat ?? this.alamat,
      pembayaran: pembayaran ?? this.pembayaran,
      total_harga: total_harga ?? this.total_harga,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(id != null){
      result.addAll({'id': id});
    }
    result.addAll({'nama': nama});
    result.addAll({'no_hp': no_hp});
    result.addAll({'instrumen': instrumen});
    result.addAll({'hari': hari});
    result.addAll({'durasi': durasi});
    result.addAll({'opsi': opsi});
    result.addAll({'alamat': alamat});
    result.addAll({'pembayaran': pembayaran});
    result.addAll({'total_harga': total_harga});
    if(status != null){
      result.addAll({'status': status});
    }
  
    return result;
  }

  factory Alatmusik.fromMap(Map<String, dynamic> map) {
    return Alatmusik(
      id: map['id'].toString(),
      nama: map['nama'] ?? '',
      no_hp: map['no_hp'] ?? '',
      instrumen: map['instrumen'] ?? '',
      hari: map['hari'] ?? '',
      durasi: map['durasi'] ?? '',
      opsi: map['opsi'] ?? '',
      alamat: map['alamat'] ?? '',
      pembayaran: map['pembayaran'] ?? '',
      total_harga: map['total_harga'] ?? '',
      status: map['status'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Alatmusik.fromJson(String source) =>
      Alatmusik.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Alatmusik(id: $id, nama: $nama, no_hp: $no_hp, instrumen: $instrumen, hari: $hari, durasi: $durasi, opsi: $opsi, alamat: $alamat, pembayaran: $pembayaran, total_harga: $total_harga, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Alatmusik &&
      other.id == id &&
      other.nama == nama &&
      other.no_hp == no_hp &&
      other.instrumen == instrumen &&
      other.hari == hari &&
      other.durasi == durasi &&
      other.opsi == opsi &&
      other.alamat == alamat &&
      other.pembayaran == pembayaran &&
      other.total_harga == total_harga &&
      other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      nama.hashCode ^
      no_hp.hashCode ^
      instrumen.hashCode ^
      hari.hashCode ^
      durasi.hashCode ^
      opsi.hashCode ^
      alamat.hashCode ^
      pembayaran.hashCode ^
      total_harga.hashCode ^
      status.hashCode;
  }
}
