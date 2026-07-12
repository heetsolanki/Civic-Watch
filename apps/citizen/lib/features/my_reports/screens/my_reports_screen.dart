import 'package:citizen/exports.dart';

class MyReportsScreen extends StatefulWidget {
  const MyReportsScreen({super.key});

  @override
  State<MyReportsScreen> createState() => _MyReportsScreenState();
}

class _MyReportsScreenState extends State<MyReportsScreen> {
  String username = '';
  int _selectedIndex = 0;
  static const List<String> filters = [
    'All',
    'Reported',
    'Verified',
    'Assigned',
    'Resolved',
  ];

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  void loadUser() async {
    final user = await AppPreferences.getUser();
    if (mounted) {
      setState(() {
        username = user['username'] ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final reports = context.select<ReportsProvider, List<Report>>(
      (p) => p.reports,
    );

    if (reports.isEmpty) {
      return const EmptyState(
        icon: Icons.assignment_outlined,
        title: 'No Reports Yet!',
        description:
            'You haven\'t submitted any reports yet. Your reports will appear here.',
      );
    }

    final filteredReports = reports.where((report) {
      final matchUser = username == report.userId;
      final matchStatus =
          _selectedIndex == 0 ||
          report.status.toLowerCase() == filters[_selectedIndex].toLowerCase();
      return matchUser && matchStatus;
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          const SizedBox(height: 8),
          SizedBox(
            height: 60,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: filters.length,
              itemBuilder: (context, index) {
                final isSelected = _selectedIndex == index;
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4.0,
                    vertical: 8,
                  ),
                  child: ChoiceChip(
                    selectedColor: AppColors.primary,
                    backgroundColor: AppColors.cardColor,
                    labelStyle: GoogleFonts.openSans(
                      color: isSelected ? Colors.white : AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                      side: BorderSide(
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.primary.withOpacity(0.1),
                        width: 1,
                      ),
                    ),
                    showCheckmark: false,
                    label: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Text(filters[index]),
                    ),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) {
                        HapticFeedback.lightImpact();
                        setState(() => _selectedIndex = index);
                      }
                    },
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: filteredReports.isEmpty
                ? const _EmptyFilteredState()
                : ListView.builder(
                    padding: const EdgeInsets.only(top: 8, bottom: 100),
                    physics: const BouncingScrollPhysics(),
                    itemCount: filteredReports.length,
                    itemBuilder: (context, index) {
                      final report = filteredReports[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        child: Center(child: IssueCard(report: report)),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _EmptyFilteredState extends StatelessWidget {
  const _EmptyFilteredState();

  @override
  Widget build(BuildContext context) {
    return const EmptyState(
      icon: Icons.assignment_late_rounded,
      title: 'No Reports Found',
      description: 'No reports found in this category',
    );
  }
}
