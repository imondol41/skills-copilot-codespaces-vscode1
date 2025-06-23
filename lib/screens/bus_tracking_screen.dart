import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BusTrackingScreen extends StatefulWidget {
  const BusTrackingScreen({super.key});

  @override
  State<BusTrackingScreen> createState() => _BusTrackingScreenState();
}

class _BusTrackingScreenState extends State<BusTrackingScreen> {
  GoogleMapController? mapController;
  
  // Initial camera position (you can adjust these coordinates)
  final LatLng _center = const LatLng(44.4056, 8.9463); // Genova, Italy
  
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850], // Dark theme background
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'SMUCT BUS SERVICE',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Map Section
          Expanded(
            flex: 2,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 10,
              ),
              onMapCreated: _onMapCreated,
            ),
          ),
          // Bus Details Section
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24.0),
                  topRight: Radius.circular(24.0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'V-Bus-1845',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'Genova-Milano',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'On Time',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          _buildTimelineStop('Genova-Fant D\'italia', 'Starting stop', '16:45', isFirst: true),
                          _buildTimelineConnector(),
                          _buildTimelineStop('2 stops', '', '', isStopPoint: false),
                           _buildTimelineConnector(),
                          _buildTimelineStop('Milano-Malpensa', 'Final stop', '19:53', isLast: true),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTimelineStop(String title, String subtitle, String time, {bool isFirst = false, bool isLast = false, bool isStopPoint = true}) {
    return Row(
      children: [
        Column(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isStopPoint ? Colors.yellow : Colors.transparent,
                border: Border.all(color: Colors.white, width: isStopPoint ? 2 : 0),
              ),
            ),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              if (subtitle.isNotEmpty)
                Text(
                  subtitle,
                  style: const TextStyle(color: Colors.white70),
                ),
            ],
          ),
        ),
        Text(
          time,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildTimelineConnector() {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 9),
          width: 2,
          height: 40,
          color: Colors.white,
        ),
        const SizedBox(width: 16),
        // Dashed line could be more complex, using a custom painter or package
        Expanded(
          child: Container(
            height: 1,
            color: Colors.white30,
          ),
        ),
      ],
    );
  }
} 