import 'package:citizen/exports.dart';

class BottomNavbar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const BottomNavbar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.white.withOpacity(0.2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 5,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          height: 65,
          clipBehavior: Clip.none,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () => onTap(0),
                icon: Icon(
                  Icons.home_rounded,
                  color: selectedIndex == 0 ? AppColors.primary : Colors.grey,
                  size: 26,
                ),
              ),
              IconButton(
                onPressed: () => onTap(1),
                icon: Icon(
                  Icons.search_rounded,
                  color: selectedIndex == 1 ? AppColors.primary : Colors.grey,
                  size: 26,
                ),
              ),
              SizedBox(width: 30),
              IconButton(
                onPressed: () => onTap(3),
                icon: Icon(
                  Icons.assignment_rounded,
                  color: selectedIndex == 3 ? AppColors.primary : Colors.grey,
                  size: 26,
                ),
              ),
              IconButton(
                onPressed: () => onTap(4),
                icon: Icon(
                  Icons.person_rounded,
                  color: selectedIndex == 4 ? AppColors.primary : Colors.grey,
                  size: 26,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
