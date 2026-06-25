import 'package:citizen/exports.dart';

class TopCard extends StatefulWidget {
  final String name;
  final String phone;
  final String email;

  const TopCard({
    super.key,
    required this.name,
    required this.phone,
    required this.email,
  });

  @override
  State<TopCard> createState() => TopCardState();
}

class TopCardState extends State<TopCard> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 1),
            blurRadius: 0.9,
            spreadRadius: 0.8,
            color: Colors.black.withOpacity(0.3),
          ),
        ],
      ),
      width: width * 0.85,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: AppColors.primary.withOpacity(0.3),
              ),
              Icon(Icons.person, size: 30, color: AppColors.textPrimary),
            ],
          ),
          const SizedBox(width: 16),
          Column(
            spacing: 3,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.name,
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                widget.email,
                style: GoogleFonts.openSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                widget.phone,
                style: GoogleFonts.openSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
