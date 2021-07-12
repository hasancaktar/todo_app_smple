import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:todo_app_smple/core/controller/todo_controller.dart';
import 'package:todo_app_smple/screen/todoscreen.dart';

class Haritaview extends StatefulWidget {
  @override
  _HaritaviewState createState() => _HaritaviewState();
}

class _HaritaviewState extends State<Haritaview> {
  TodoController _todoController = Get.put(TodoController());
  late MapController mapController;
  late Map<String, LatLng> koordinatlar;
  late List<Marker> marker;
  late TodoScreen _todoScreen;
  late String _konumum;

  @override
  void initState() {
    mapController =  MapController();

    koordinatlar =  Map<String, LatLng>();
    koordinatlar.putIfAbsent("EV", () => new LatLng(37.066666, 37.383331));
    koordinatlar.putIfAbsent("İŞ", () => new LatLng(37.066666, 37.38531));
    koordinatlar.putIfAbsent("OKUL", () => new LatLng(37.066006, 37.3701));

    marker = <Marker>[];

    for (int i = 0; i < koordinatlar.length; i++) {
      marker.add(new Marker(
        width: 80.0,
        height: 80.0,
        point: koordinatlar.values.elementAt(i),
        builder: (ctx) =>
        new Icon(
          Icons.pin_drop,
          color: Colors.red,
        ),
      ));
    }
  }

  void _koordinatGoster(int index) {
    mapController.move(koordinatlar.values.elementAt(index), 13.0);
  }

  List<Widget> _konumaGoreButtOlustur() {
    List<Widget> list = <Widget>[];

    for (int i = 0; i < koordinatlar.length; i++) {
      list.add( ElevatedButton(
        onPressed: () {
          _koordinatGoster(i);
          _konumum= koordinatlar.keys.elementAt(i);
         //
          print(koordinatlar.keys.elementAt(i));
        },
        child:  Text(koordinatlar.keys.elementAt(i)),
      ));
    }
    return list;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        // padding: new EdgeInsets.all(32.0),
          child: Center(
              child: Column(
                  children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: _konumaGoreButtOlustur(),
      ),
      Flexible(
        child: FlutterMap(
          mapController: mapController,
          options: MapOptions(
              center: LatLng(37.066666, 37.383331), zoom: 10.0),
          layers: [
            TileLayerOptions(
              urlTemplate:
              "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c'],
            ),
            new MarkerLayerOptions(markers: marker),
          ],
        ),
      )
      ],
    ),)
    ,
    )
    ,
    );
  }
}
