import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mapy/services/location.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _initialLocation;
  String? query;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    Position position = await LocationService().getCurrentLocation();
    setState(() {
      _initialLocation = LatLng(position.latitude, position.longitude);
    });
    controller.move(_initialLocation!,16);
  }

  final controller = MapController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            if (_initialLocation != null)
              FlutterMap(
                options: MapOptions(
                  initialCenter: _initialLocation!,
                  initialZoom: 16,
                  maxZoom: 20,
                ),
                mapController: controller,
                children: [
                  TileLayer(
                    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        height: 80,
                        width: 80,
                        point: _initialLocation!,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.2),
                            shape: BoxShape.circle
                          ),
                          child: Icon(LucideIcons.mapPin,size: 20, color: Colors.red.shade800,),
                        ),
                        rotate: true
                      ),
                    ],
                  ),
                ],
              )
            else
              Center(
                child: CircularProgressIndicator(),
              ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SearchBar(
                hintText: "search on mapy",
                constraints: BoxConstraints(
                 minHeight: 45
                ),
                trailing: [
                  IconButton(
                    icon: Icon(LucideIcons.search),
                    onPressed: () async{
                      await LocationService().getLocation();
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(LucideIcons.locateFixed),
        backgroundColor: Color(0xFF131b23),
        foregroundColor: Color(0xFFe7dfc6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100)
        ),
        onPressed: (){
          _getCurrentLocation();
        },
      ),
    );
  }
}
