import 'package:citizen/exports.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String phone;
  final String email;
  final int civicPoints;
  final String? imagePath;

  const ProfileHeader({
    super.key,
    required this.name,
    required this.phone,
    required this.email,
    required this.civicPoints,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    final hasImage = imagePath != null && imagePath!.isNotEmpty;
    double width = MediaQuery.of(context).size.width;
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.primary.withOpacity(0.5),
                AppColors.textPrimary.withOpacity(0.5),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 4),
                color: Colors.black.withOpacity(0.1),
                blurRadius: 5,
              ),
            ],
          ),
          width: width * 0.85,
          height: 260,
        ),
        Container(
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
            color: AppColors.cardColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          width: width * 0.85,
          height: 175,
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Column(
              children: [
                SizedBox(height: 60),
                Text(
                  name,
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.verified_user_rounded,
                      size: 20,
                      color: AppColors.smallText,
                    ),
                    SizedBox(width: 2),
                    Text(
                      'Verified Citizen',
                      style: GoogleFonts.openSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.amber.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.amber.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.emoji_events_rounded,
                        size: 16,
                        color: Colors.amber,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '$civicPoints Civic Points',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.amber[800],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 45,
          child: Hero(
            tag: 'profile-avatar',
            child: CircleAvatar(
              radius: 45,
              backgroundColor: AppColors.cardColor,
              child: CircleAvatar(
                radius: 42,
                backgroundImage: hasImage ? FileImage(File(imagePath!)) : null,
                child: !hasImage
                    ? const Icon(
                        Icons.person,
                        size: 45,
                        color: AppColors.textPrimary,
                      )
                    : null,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
