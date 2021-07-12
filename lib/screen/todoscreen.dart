import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_app_smple/core/db_helper/db_helper.dart';
import 'package:todo_app_smple/core/model/db_model.dart';
import 'package:todo_app_smple/screen/haritaview.dart';

class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  late DB _database;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _baslikController = TextEditingController();
  TextEditingController _tarihController = TextEditingController();
  int _temp = 0;
  List<TodoModel> datalar = [];
  bool dataGetirme = true;
  int currentIndex = 0;

  DateTime _tarih = DateTime.now();
  final DateFormat _dateFormat = DateFormat("MMM dd, yyyy");
  List<String> _konumListe = ["Ev", "İş", "Diğer"];
  String? _konum = "Ev";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _database = DB();
    getirData();
  }

  void getirData() async {
    datalar= await _database.dataGetir();
    setState(() {
      dataGetirme = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () => Get.defaultDialog(
                  title: "Uyarı",
                  middleText:
                  "Eğer not eklediğiniz halde görünmüyorsa uygulamayı kapatıp yeniden açın"),
              icon: Icon(Icons.info))
        ],
        title: Center(child: Text("Todo")),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: notEkle,
        child: Icon(Icons.add),
      ),
      body: dataGetirme
          ? Center(child: Text("Eğer not eklediğiniz halde görünmüyorsa \n uygulamayı kapatıp yeniden açın"))
          :    ListView.builder(
          itemCount: datalar.length,
          itemBuilder: (context, index) {
            String item = datalar[index].id.toString();
            print("******" + datalar.length.toString());
            return buildDismissible(item, index);
          }),
    );
  }

  Dismissible buildDismissible(String item, int index) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      background: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                "Sil",
                style: TextStyle(color: Colors.white, fontSize: 30),
              )),
        ),
        color: Colors.red,
      ),
      key: Key(item),
      onDismissed: (dismissed) {
        notSil(index);
      },
      child: Card(
        color: datalar[index].tamamlandimi == 1
            ? Colors.green[400]
            : Colors.red[200],
        child: buildListTile(index),
      ),
    );
  }

  ListTile buildListTile(int index) {
    return ListTile(
      trailing: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Checkbox(
              value: datalar[index].tamamlandimi == 1 ? true : false,
              onChanged: (val) {
                if (val == true) {
                  _temp = 1;
                } else
                  _temp = 0;
                datalar[index].tamamlandimi = _temp;
                checkboxDurumu(index);
                setState(() {});
                print("*****" + val.toString());
                //      _database.
              }),
          Icon(Icons.arrow_left)
        ],
      ),
      leading: IconButton(
        onPressed: () {
          setState(() {
            notUDuzenle(index);
          });
        },
        icon: Icon(
          Icons.edit,
          color: Colors.deepOrange,
        ),
      ),
      title: Text(datalar[index].baslik!),
      subtitle: Text("${datalar[index].tarih} - ${datalar[index].konum}"),
    );
  }

  ///NOT EKLEME METDOU
  notEkle() {
    return Get.defaultDialog(
        title: "Not Ekle",
        content: Form(
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
                ElevatedButton(onPressed: ()=>Get.to(Haritaview()), child: Text("Haritadan Konum Seç")),
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
                      if (_formKey.currentState!.validate()) {
                        TodoModel dataLokal = dataEkleme();
                        dataLokal.id = datalar[datalar.length -1].id!+1 ;
                        setState(() {
                          datalar.add(dataLokal);
                        });
                        print("eklendi");
                        _baslikController.clear();
                        // _konumController.clear();
                        _tarihController.clear();
                        Get.back();
                      }
                    },
                    child: Text("Ekle"))
              ],
            )));
  }

  ///NOTU DÜZENLEME METODU
  notDuzenle() {
    return Get.defaultDialog(
        title: "Güncelle",
        content: Form(
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
                  ),
                ),
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
                    decoration: InputDecoration(
                        labelText: "Konum", border: OutlineInputBorder()),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    readOnly: true,
                    onTap: tarihSec,
                    controller: _tarihController,
                    decoration: InputDecoration(
                        labelText: "Tarih", border: OutlineInputBorder()),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      TodoModel yeniData = datalar[currentIndex];
                      yeniData.baslik = _baslikController.text;
                      yeniData.tarih = _tarihController.text;
                      yeniData.konum = _konum;
                      _database.duzenle(yeniData);
                      _baslikController.clear();
                      setState(() {});
                      Get.back();
                    },
                    child: Text("Güncelle"))
              ],
            )));
  }

///VERİ TABANINA NOT EKLEME METODU
  TodoModel dataEkleme() {
    TodoModel dataLokal = TodoModel(
        baslik: _baslikController.text,
        tarih: _tarihController.text,
        konum: _konum,
        tamamlandimi: 0);
    _database.insertData(dataLokal);
    return dataLokal;
  }

///MOT DÜZENLEME
  void notUDuzenle(int index) {
    currentIndex = index;
    _baslikController.text = datalar[index].baslik!;
    _tarihController.text = datalar[index].tarih!;
    _konum = datalar[index].konum!;
    notDuzenle();
  }

  ///CHECKBOX KONTORLÜ
  void checkboxDurumu(int index) {
    currentIndex = index;

    _temp = datalar[index].tamamlandimi!;
    TodoModel yeniData = datalar[currentIndex];

    yeniData.tamamlandimi = _temp;
    _database.duzenle(yeniData);
  }

  ///SİLME
  void notSil(int index) {
    _database.sil(datalar[index].id!);
    setState(() {
      datalar.removeAt(index);
    });
  }


  ///TİME PİCKER İLE TARİH SEÇME
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
}