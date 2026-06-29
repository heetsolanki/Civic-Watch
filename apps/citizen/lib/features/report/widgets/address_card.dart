import 'package:citizen/exports.dart';

class AddressCard extends StatelessWidget {
  final String? address;
  final bool isLoading;

  const AddressCard({
    super.key,
    this.address,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Selected Location',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          if (isLoading)
            const LinearProgressIndicator(minHeight: 2)
          else
            Text(
              address ?? 'Tap on map to select address',
              style: GoogleFonts.openSans(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
        ],
      ),
    );
  }
}
