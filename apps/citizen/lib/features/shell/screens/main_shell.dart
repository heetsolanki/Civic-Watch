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

  static const List<Widget> screens = [
    HomeScreen(),
    IssuesScreen(),
    SizedBox.shrink(),
    MyReportsScreen(),
    AccountScreen(),
  ];

  Future<void> changePage(int index) async {
    if (index == 3) {
      if (!await requireLogin(context)) {
        if (mounted) setState(() => selectedIndex = 4);
        return;
      }
    }

    if (mounted) {
      setState(() {
        selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.background,
      appBar: _MainAppBar(selectedIndex: selectedIndex),
      body: IndexedStack(index: selectedIndex, children: screens),
      extendBody: true,
      bottomNavigationBar: BottomNavbar(
        selectedIndex: selectedIndex,
        onTap: changePage,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _CreateReportFAB(
        isSelected: selectedIndex == 2,
        onAuthFailure: () {
          if (mounted) setState(() => selectedIndex = 4);
        },
      ),
    );
  }
}

class _MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int selectedIndex;

  const _MainAppBar({required this.selectedIndex});

  String _getTitle(bool isLoggedIn) {
    switch (selectedIndex) {
      case 0:
        return 'CivicWatch';
      case 1:
        return 'Explore Issues';
      case 3:
        return 'My Reports';
      case 4:
        return isLoggedIn ? 'Profile' : 'Login';
      default:
        return 'CivicWatch';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = context.select<AuthProvider, bool>((a) => a.isLoggedIn);

    return AppBar(
      backgroundColor: AppColors.background,
      surfaceTintColor: Colors.transparent,
      toolbarHeight: 70,
      centerTitle: false,
      elevation: 0,
      title: Padding(
        padding: EdgeInsets.only(left: selectedIndex == 0 ? 8 : 0),
        child: Text(
          _getTitle(isLoggedIn),
          style: GoogleFonts.poppins(
            fontSize: 26,
            fontWeight: FontWeight.w800,
            color: AppColors.primary,
            letterSpacing: -0.5,
          ),
        ),
      ),
      actions: [
        if (selectedIndex == 0)
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: IconButton(
              onPressed: () {},
              style: IconButton.styleFrom(
                backgroundColor: AppColors.primary.withOpacity(0.05),
              ),
              icon: const Icon(
                Icons.notifications_outlined,
                color: AppColors.textPrimary,
                size: 24,
              ),
            ),
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}

class _CreateReportFAB extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onAuthFailure;

  const _CreateReportFAB({
    required this.isSelected,
    required this.onAuthFailure,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: FloatingActionButton(
        elevation: 4,
        shape: const CircleBorder(),
        backgroundColor: isSelected ? AppColors.primary : AppColors.textPrimary,
        onPressed: () async {
          if (!await requireLogin(
            context,
            message: 'Please log in to report an issue.',
          )) {
            onAuthFailure();
            return;
          }
          if (!context.mounted) return;
          context.push('/create-report');
        },
        child: const Icon(Icons.add_rounded, color: Colors.white, size: 36),
      ),
    );
  }
}
