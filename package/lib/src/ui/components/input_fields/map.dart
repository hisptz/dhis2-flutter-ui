import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class MapScreen extends StatefulWidget {
  final String locationText;

  const MapScreen({Key? key, required this.locationText}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController _mapController = MapController();
  Position? _selectedPosition;
  Marker? _userLocationMarker;

  @override
  void initState() {
    super.initState();

    if (widget.locationText.isNotEmpty) {
      final coords = widget.locationText.split(',');
      final latitude = double.parse(coords[0]);
      final longitude = double.parse(coords[1]);

      _userLocationMarker = Marker(
        width: 80.0,
        height: 80.0,
        point: LatLng(latitude, longitude),
        builder: (ctx) => const Icon(
          Icons.location_pin,
          color: Colors.blue,
          size: 40.0,
        ),
      );
    }
  }

  void _onMapTap(TapPosition point, LatLng latlng) {
    setState(() {
      _userLocationMarker = Marker(
        width: 80.0,
        height: 80.0,
        point: latlng,
        builder: (ctx) => const Icon(
          Icons.location_pin,
          color: Colors.blue,
          size: 40.0,
        ),
      );

      _selectedPosition = Position(
        latitude: latlng.latitude,
        longitude: latlng.longitude,
        accuracy: 0.0,
        altitude: 0.0,
        heading: 0.0,
        speed: 0.0,
        speedAccuracy: 0.0,
        timestamp: DateTime.now(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Location'),
      ),
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          center: widget.locationText.isNotEmpty
              ? LatLng(
                  double.parse(widget.locationText.split(',')[0]),
                  double.parse(widget.locationText.split(',')[1]),
                )
              : const LatLng(
                  -6.76456, 39.2484481), // Default if input field is empty
          maxZoom: 18,
          zoom: 18.0,
          onTap: _onMapTap,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app',
          ),
          MarkerLayer(
            markers: [
              if (_userLocationMarker != null) _userLocationMarker!,
            ],
          ),
        ],
      ),
      floatingActionButton: _selectedPosition != null
          ? FloatingActionButton(
              onPressed: () {
                Navigator.pop(context, _selectedPosition);
              },
              child: const Icon(Icons.check),
            )
          : null,
    );
  }
}
