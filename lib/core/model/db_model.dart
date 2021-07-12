import 'dart:convert';

class TodoModel {
  int? id;
  String? baslik;
  String? tarih;
  String? konum;
  int? tamamlandimi;

  TodoModel({
     this.id,
    this.baslik,
    this.tarih,
    this.konum,
    this.tamamlandimi,
  });

  factory TodoModel.fromMap(Map<String, dynamic> map) => TodoModel(
      id: map["id"],
      baslik: map["baslik"],
      tarih: map["tarih"],
      konum: map["konum"],
      tamamlandimi: map["tamamlandimi"]);

  Map<String, dynamic> toMap() => {
        "id": id,
        "baslik": baslik,
        "tarih": tarih,
        "konum": konum,
        "tamamlandimi": tamamlandimi
      };
}
