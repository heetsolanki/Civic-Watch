import 'package:citizen/exports.dart';

class PolicySection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const PolicySection({
    super.key,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.openSans(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        ...children,
        const Divider(height: 32, thickness: 0.5),
      ],
    );
  }
}
