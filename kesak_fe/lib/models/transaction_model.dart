class Transaction {
  final int id;
  final String title;
  final String description;
  final int amount;
  final String type;
  final int? fromTabungan;
  final int? toTabungan;
  final String icon;
  final String category;
  final String date;
  final String status;

  Transaction({
    required this.id,
    required this.title,
    required this.description,
    required this.amount,
    required this.type,
    this.fromTabungan,
    this.toTabungan,
    required this.icon,
    required this.category,
    required this.date,
    required this.status,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      amount: json['amount'],
      type: json['type'],
      fromTabungan: json['from_tabungan'],
      toTabungan: json['to_tabungan'],
      icon: json['icon'],
      category: json['category'],
      date: json['date'],
      status: json['status'],
    );
  }
}

class Tabungan {
  final int id;
  final String nama;
  final String deskripsi;
  final int saldo;
  final int target;
  final String icon;
  final String color;
  final String dibuat;

  Tabungan({
    required this.id,
    required this.nama,
    required this.deskripsi,
    required this.saldo,
    required this.target,
    required this.icon,
    required this.color,
    required this.dibuat,
  });

  factory Tabungan.fromJson(Map<String, dynamic> json) {
    return Tabungan(
      id: json['id'],
      nama: json['nama'],
      deskripsi: json['deskripsi'],
      saldo: json['saldo'],
      target: json['target'],
      icon: json['icon'],
      color: json['color'],
      dibuat: json['dibuat'],
    );
  }
}
