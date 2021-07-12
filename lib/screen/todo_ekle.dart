import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_app_smple/core/db_helper/db_helper.dart';
import 'package:todo_app_smple/core/model/db_model.dart';
/*
import 'haritaview.dart';

class NotEkle extends StatefulWidget {
  @override
  _NotEkleState createState() => _NotEkleState();
}

class _NotEkleState extends State<NotEkle> {



  final _formKey =GlobalKey<FormState>();
  TextEditingController _baslikController = TextEditingController();
  TextEditingController _tarihController = TextEditingController();
  String? _konum = "Ev";
  List<String> _konumListe = ["Ev", "İş", "Diğer"];
  DateTime _tarih = DateTime.now();
  final DateFormat _dateFormat = DateFormat("MMM dd, yyyy");
  late DB _database;
  List<TodoModel> datalar = [];




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Not EKLE"),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _baslikController,
                      validator: (value) =>
                      value!.trim().isEmpty ? "Başlık Gir" : null,
                      decoration: InputDecoration(
                          labelText: "Başlık", border: OutlineInputBorder()),
                      //   onTap: tarihSec,
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () =>Get.to(()=>Haritaview()), child: Text("Hatırlatma Konumunu Seç")),
                  ClipRect(child:Text(Degerler.knm??"null")),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButtonFormField(
                      onChanged: (val) {
                        setState(() {
                          _konum = val as String?;
                        });
                      },
                      value: _konum,
                      items: _konumListe
                          .map((String konum) => DropdownMenuItem(
                        child: Text(konum),
                        value: konum,
                      ))
                          .toList(),

                      //controller: _konumController,
                      decoration: InputDecoration(
                          labelText: "Konum", border: OutlineInputBorder()),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      onTap: tarihSec,
                      readOnly: true,
                      controller: _tarihController,
                      decoration: InputDecoration(
                          labelText: "Tarih", border: OutlineInputBorder()),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        // print("datalar.lenth: "+datalar.length.toString());
                        //  print("datalar[datalar.length - 1].id! + 1: "+(datalar[datalar.length - 1].id! + 1).toString());
                        // print("datalar[datalar.length - 1].id! + 1: " +
                        //     (datalar[datalar.length - 1].id! + 1).toString());
                        if (_formKey.currentState!.validate()) {
                          TodoModel dataLokal = dataEkleme();
                          //   _database.insertData(dataLokal);

                          print("datalar.lenth: " + datalar.length.toString());

                          dataLokal.id = datalar[datalar.length - 1].id!+1;
                          setState(() {
                            datalar.add(dataLokal);
                          });
                          //dataGetirme=true;
                          print("eklendi");
                          _baslikController.clear();
                          // _konumController.clear();
                          _tarihController.clear();
                         // getirData();
                          Get.back();
                        }
                      },
                      child: Text("Ekle"))
                ],
              ))
        ],),
      ),
    );
  }
  tarihSec() async {
    final DateTime? tarih = await showDatePicker(
        context: context,
        initialDate: _tarih,
        firstDate: DateTime(2000),
        lastDate: DateTime(2200));
    if (tarih != null) {
      setState(() {
        _tarih = tarih;
      });
      _tarihController.text = _dateFormat.format(tarih);
    }
  }
  TodoModel dataEkleme() {
    TodoModel dataLokal = TodoModel(
        baslik: _baslikController.text,
        tarih: _tarihController.text,
        konum: _konum,
        tamamlandimi: 0);
    _database.insertData(dataLokal);
    return dataLokal;
  }
}
*/