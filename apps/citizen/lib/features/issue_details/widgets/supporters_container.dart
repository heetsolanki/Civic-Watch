import 'package:citizen/exports.dart';

class SupportersContainer extends StatefulWidget {
  final IssueData issue;

  const SupportersContainer({super.key, required this.issue});

  @override
  State<SupportersContainer> createState() => _SupportersContainerState();
}

class _SupportersContainerState extends State<SupportersContainer> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  widget.issue.supportedCount,
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text('Supporters', style: GoogleFonts.poppins(fontSize: 14)),
              ],
            ),
            AppButton(
              text: 'I\'m Affected Too',
              prefixIcon: const Icon(Icons.people_alt),
              borderRadius: 5,
              width: width * 0.45,
              backgroundColor: AppColors.textPrimary,
              onPressed: () {
                AppToast.success(context, 'You\'re supporting this issue');
              },
            ),
          ],
        ),
      ),
    );
  }
}
