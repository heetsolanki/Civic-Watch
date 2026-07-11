import 'package:citizen/exports.dart';

class SupportersContainer extends StatelessWidget {
  final Report report;

  const SupportersContainer({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    return InfoCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  // TODO: Fetch supporters count from Supabase
                  '1',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  'Supporters',
                  style: GoogleFonts.openSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          AppButton(
            text: "I'm Affected Too",
            width: 180,
            height: 44,
            prefixIcon: const Icon(Icons.thumb_up_alt_rounded, size: 18),
            onPressed: () {
              HapticFeedback.mediumImpact();
              AppToast.success(context, "You're now supporting this issue!");
            },
          ),
        ],
      ),
    );
  }
}
