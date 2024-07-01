import 'dart:convert';

class Recording {
  final String? id;
  final String nama_band;
  final String jam_sewa;
  final String hari;
  final String durasi;
  final String pembayaran;
  final String total_harga;
  Recording({
    this.id,
    required this.nama_band,
    required this.jam_sewa,
    required this.hari,
    required this.durasi,
    required this.pembayaran,
    required this.total_harga,
  });

  Recording copyWith({
    String? id,
    String? nama_band,
    String? jam_sewa,
    String? hari,
    String? durasi,
    String? pembayaran,
    String? total_harga,
  }) {
    return Recording(
      id: id ?? this.id,
      nama_band: nama_band ?? this.nama_band,
      jam_sewa: jam_sewa ?? this.jam_sewa,
      hari: hari ?? this.hari,
      durasi: durasi ?? this.durasi,
      pembayaran: pembayaran ?? this.pembayaran,
      total_harga: total_harga ?? this.total_harga,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(id != null){
      result.addAll({'id': id});
    }
    result.addAll({'nama_band': nama_band});
    result.addAll({'jam_sewa': jam_sewa});
    result.addAll({'hari': hari});
    result.addAll({'durasi': durasi});
    result.addAll({'pembayaran': pembayaran});
    result.addAll({'total_harga': total_harga});
  
    return result;
  }

  factory Recording.fromMap(Map<String, dynamic> map) {
    return Recording(
      id: map['id'],
      nama_band: map['nama_band'] ?? '',
      jam_sewa: map['jam_sewa'] ?? '',
      hari: map['hari'] ?? '',
      durasi: map['durasi'] ?? '',
      pembayaran: map['pembayaran'] ?? '',
      total_harga: map['total_harga'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Recording.fromJson(String source) => Recording.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Recording(id: $id, nama_band: $nama_band, jam_sewa: $jam_sewa, hari: $hari, durasi: $durasi, pembayaran: $pembayaran, total_harga: $total_harga)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Recording &&
      other.id == id &&
      other.nama_band == nama_band &&
      other.jam_sewa == jam_sewa &&
      other.hari == hari &&
      other.durasi == durasi &&
      other.pembayaran == pembayaran &&
      other.total_harga == total_harga;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      nama_band.hashCode ^
      jam_sewa.hashCode ^
      hari.hashCode ^
      durasi.hashCode ^
      pembayaran.hashCode ^
      total_harga.hashCode;
  }
}
