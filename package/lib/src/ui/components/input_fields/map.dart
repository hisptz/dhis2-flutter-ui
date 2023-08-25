import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class MapScreen extends StatefulWidget {
  final String locationPoint;
  final Color color;
  final String label;
  final bool? isReadOnly;

  const MapScreen({
    Key? key,
    required this.locationPoint,
    required this.label,
    this.color = Colors.blue,
    this.isReadOnly = false,
  }) : super(key: key);

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

    if (widget.locationPoint.isNotEmpty) {
      final coordinates = widget.locationPoint.split(',');
      final latitude = double.parse(coordinates.first);
      final longitude = double.parse(coordinates.last);

      _userLocationMarker = Marker(
        width: 80.0,
        height: 80.0,
        point: LatLng(latitude, longitude),
        builder: (ctx) => Icon(
          Icons.location_pin,
          color: widget.color,
          size: 40.0,
        ),
      );
    }
  }

  void _onTapMapCanvas(TapPosition point, LatLng coordinate) {
    setState(() {
      if (widget.isReadOnly == false) {
        _userLocationMarker = Marker(
          width: 80.0,
          height: 80.0,
          point: coordinate,
          builder: (BuildContext context) => Icon(
            Icons.location_pin,
            color: widget.color,
            size: 40.0,
          ),
        );

        _selectedPosition = Position(
          latitude: coordinate.latitude,
          longitude: coordinate.longitude,
          accuracy: 0.0,
          altitude: 0.0,
          heading: 0.0,
          speed: 0.0,
          speedAccuracy: 0.0,
          timestamp: DateTime.now(),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.color,
        title: Text(widget.label),
      ),
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          center: widget.locationPoint.isNotEmpty
              ? LatLng(
                  double.parse(widget.locationPoint.split(',')[0]),
                  double.parse(widget.locationPoint.split(',')[1]),
                )
              : const LatLng(
                  0,
                  0,
                ), // Default if input field is empty
          maxZoom: 18,
          zoom: 18.0,
          onTap: _onTapMapCanvas,
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
      floatingActionButton:
          _selectedPosition != null && widget.isReadOnly == false
              ? FloatingActionButton(
                  focusColor: widget.color,
                  hoverColor: widget.color,
                  backgroundColor: widget.color,
                  onPressed: () {
                    Navigator.pop(context, _selectedPosition);
                  },
                  child: const Icon(Icons.check),
                )
              : null,
    );
  }
}
