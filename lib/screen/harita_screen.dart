import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
//import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:latlong2/latlong.dart';
import 'package:todo_app_smple/core/controller/todo_controller.dart';

class HaritaScreen extends StatefulWidget {
  @override
  _HaritaScreenState createState() => _HaritaScreenState();
}

class _HaritaScreenState extends State<HaritaScreen> {

  TodoController _todoController =Get.find();

  //GlobalKey<OSMFlutterState> mapKey = GlobalKey<OSMFlutterState>();
  MapController _mapController=MapController();
  //MapController _mapController = MapController();

  List<Marker> _makers = [];
  var _noktalar = <LatLng>[
    LatLng(55.7, -20.4),
    LatLng(50.71, -74.80),
    LatLng(50.71, -74.80),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        new FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              // onTap: (){
              //
              // },
              minZoom: 10,
             // maxZoom: _maxzoom,
              center: LatLng(55.4,-20.4),
            ),
            layers: [
              new TileLayerOptions(
                  urlTemplate:
                  'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: ['a', 'b', 'c']),
              new MarkerLayerOptions(
                  markers:  [
              for (int i = 0; i < _makers.length; i++) _makers[i],
            ]),

            ]
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: new FloatingActionButton(
              onPressed: (){
                _mapController.move(LatLng(48.8587372,2.2945457), 13);

              },
              child: Icon(Icons.gps_fixed),
            ),
          ),
        ),
      ],
    );
  }
}

/*



FlutterMap(
            mapController: _mapController,
            options: MapOptions(
                center: LatLng(50.71, -74.80),
                minZoom: 10,
                onTap: (lat) {
                  setState(() {
                    _makers.add(Marker(
                        width: 50,
                        height: 50,
                        point: LatLng(50.71, -74.80),
                        builder: (context) => Container(
                              child: IconButton(
                                icon: Icon(
                                  Icons.maps_ugc,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  return print("sadasd");
                                },
                              ),
                            )));
                    print(_makers.length);
                  });
                }),
            layers: [

              TileLayerOptions(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ["a", "b", "c"]),
              MarkerLayerOptions(markers: [
                for (int i = 0; i < _makers.length; i++) _makers[i],
              ]),
              PolylineLayerOptions(
                  polylines: [Polyline(color: Colors.red, points: _noktalar)])
            ],
          )



OSMFlutter(
        controler:mapController,
        currentLocation: false,
        road: Road(
                startIcon: MarkerIcon(
                  icon: Icon(
                    Icons.person,
                    size: 64,
                    color: Colors.brown,
                  ),
                ),
                roadColor: Colors.yellowAccent,
        ),
        markerIcon: MarkerIcon(
        icon: Icon(
          Icons.person_pin_circle,
          color: Colors.blue,
          size: 56,
          ),
        ),
        initPosition: GeoPoint(latitude: 47.35387, longitude: 8.43609),
    );
 */