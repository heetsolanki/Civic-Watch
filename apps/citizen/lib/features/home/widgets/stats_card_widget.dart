import 'package:citizen/exports.dart';

class StatsCardWidget extends StatelessWidget {
  final double? width;
  final IconData icon;
  final Color color;
  final String statNum;
  final String text;

  const StatsCardWidget({
    super.key,
    this.width,
    required this.icon,
    required this.color,
    required this.statNum,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 1),
            blurRadius: 0.9,
            spreadRadius: 0.8,
            color: Colors.black.withOpacity(0.3),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(vertical: 20),
      width: width,
      child: Column(
        spacing: 5,
        children: [
          Icon(icon, size: 36, color: color),
          Text(
            statNum,
            style: GoogleFonts.poppins(
              fontSize: 26,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
          Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }
}
