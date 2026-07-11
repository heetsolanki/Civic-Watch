import 'package:citizen/exports.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int step;
  final String title;
  final VoidCallback onBack;

  const CustomAppBar({
    super.key,
    required this.step,
    required this.onBack,
    this.title = 'Raise Issue',
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
      ),
      leading: IconButton(
        onPressed: onBack,
        icon: const Icon(Icons.close, size: 30),
        tooltip: 'Back to Home',
      ),
      toolbarHeight: 65,
      centerTitle: true,
      elevation: 5,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 23,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          Text(
            'Step $step/5',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(65);
}
