import 'package:citizen/exports.dart';

import '../widgets/bottom_navbar.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int selectedIndex = 0;
  final screens = [
    const HomeScreen(),
    const IssuesScreen(),
    const ReportScreen(),
    const MyReportsScreen(),
    const ProfileScreen(),
  ];

  void changePage(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        centerTitle: true,
        elevation: 5,
        title: Text(
          'CivicWatch',
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.notifications, color: AppColors.textPrimary),
            ),
          ),
        ],
      ),
      body: IndexedStack(index: selectedIndex, children: screens),
      extendBody: true,
      bottomNavigationBar: BottomNavbar(
        selectedIndex: selectedIndex,
        onTap: changePage,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(top: 75),
        child: FloatingActionButton(
          elevation: 0,
          shape: const CircleBorder(),
          backgroundColor: selectedIndex == 2
              ? AppColors.primary
              : AppColors.textPrimary,
          onPressed: () => changePage(2),
          child: const Icon(Icons.add, color: Colors.white, size: 34),
        ),
      ),
    );
  }
}
