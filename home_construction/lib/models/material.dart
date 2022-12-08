import 'dart:ui';

class MaterialItem {
  final String id;
  final String name;
  final String unit;
  double quantity;
  double total;
  final List<Record> records;

  MaterialItem({
    required this.id,
    required this.name,
    required this.unit,
    required this.quantity,
    required this.total,
    required this.records,
  });
}

class Record {
  final String id;
  final double quantity;
  final double pricePerUnit;
  final DateTime date;
  final Image? image;

  Record({
    required this.id,
    required this.quantity,
    required this.pricePerUnit,
    required this.date,
    this.image,
  });
}
