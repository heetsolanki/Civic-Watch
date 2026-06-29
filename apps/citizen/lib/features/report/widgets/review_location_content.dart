import 'package:citizen/exports.dart';
import 'package:latlong2/latlong.dart';

class ReviewLocationContent extends StatelessWidget {
  final double latitude;
  final double longitude;
  final String address;

  const ReviewLocationContent({
    super.key,
    required this.latitude,
    required this.longitude,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(top: 10),
          height: 200,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: FlutterMap(
            options: MapOptions(
              initialCenter: LatLng(latitude, longitude),
              initialZoom: 16,
              interactionOptions: const InteractionOptions(
                flags: InteractiveFlag.none,
              ),
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.yourapp.civicwatch',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: LatLng(latitude, longitude),
                    width: 40,
                    height: 40,
                    child: const Icon(
                      Icons.location_pin,
                      size: 40,
                      color: AppColors.danger,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.location_on_rounded,
                size: 20,
                color: AppColors.primary,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  address,
                  style: GoogleFonts.openSans(
                    fontSize: 14,
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
