import 'package:citizen/core/auth/auth_guard.dart';
import 'package:citizen/exports.dart';

class MainShell extends StatefulWidget {
  final int initialIndex;

  const MainShell({super.key, this.initialIndex = 0});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialIndex;
  }

  final screens = [
    const HomeScreen(),
    const IssuesScreen(),
    const SizedBox.shrink(),
    const MyReportsScreen(),
    const AccountScreen(),
  ];

  Future<void> changePage(int index) async {
    if (index == 3) {
      if (!await requireLogin(context)) return;
    }

    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cardColor,
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
        ),
        toolbarHeight: 65,
        centerTitle: true,
        elevation: 5,
        title: Text(
          'CivicWatch',
          style: GoogleFonts.poppins(
            fontSize: 25,
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
        padding: EdgeInsets.only(top: 70),
        child: FloatingActionButton(
          elevation: 0,
          shape: const CircleBorder(),
          backgroundColor: selectedIndex == 2
              ? AppColors.primary
              : AppColors.textPrimary,
          onPressed: () async {
            if (!await requireLogin(context)) return;

            if (!context.mounted) return;

            context.push('/create-report');
          },
          child: const Icon(Icons.add, color: Colors.white, size: 34),
        ),
      ),
    );
  }
}
