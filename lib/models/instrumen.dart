import 'dart:convert';

class Instrumen {
  final String? id;
  final String nama_instrumen;
  final String jenis;
  Instrumen({
    this.id,
    required this.nama_instrumen,
    required this.jenis,
  });

  Instrumen copyWith({
    String? id,
    String? nama_instrumen,
    String? jenis,
  }) {
    return Instrumen(
      id: id ?? this.id,
      nama_instrumen: nama_instrumen ?? this.nama_instrumen,
      jenis: jenis ?? this.jenis,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(id != null){
      result.addAll({'id': id});
    }
    result.addAll({'nama_instrumen': nama_instrumen});
    result.addAll({'jenis': jenis});
  
    return result;
  }

  factory Instrumen.fromMap(Map<String, dynamic> map) {
    return Instrumen(
      id: map['id'].toString(),
      nama_instrumen: map['nama_instrumen'] ?? '',
      jenis: map['jenis'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Instrumen.fromJson(String source) => Instrumen.fromMap(json.decode(source));

  @override
  String toString() => 'Instrumen(id: $id, nama_instrumen: $nama_instrumen, jenis: $jenis)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Instrumen &&
      other.id == id &&
      other.nama_instrumen == nama_instrumen &&
      other.jenis == jenis;
  }

  @override
  int get hashCode => id.hashCode ^ nama_instrumen.hashCode ^ jenis.hashCode;
}
