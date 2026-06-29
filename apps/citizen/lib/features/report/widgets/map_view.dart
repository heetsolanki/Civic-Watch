import 'package:citizen/exports.dart';
import 'package:latlong2/latlong.dart';

class MapView extends StatelessWidget {
  final AnimatedMapController animatedMapController;
  final LatLng selectedLocation;
  final Function(LatLng) onTap;

  const MapView({
    super.key,
    required this.animatedMapController,
    required this.selectedLocation,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FlutterMap(
        mapController: animatedMapController.mapController,
        options: MapOptions(
          initialCenter: selectedLocation,
          initialZoom: 18,
          onTap: (_, point) => onTap(point),
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.yourapp.civicwatch',
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: selectedLocation,
                width: 50,
                height: 50,
                child: const Icon(
                  Icons.location_pin,
                  size: 35,
                  color: AppColors.danger,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
