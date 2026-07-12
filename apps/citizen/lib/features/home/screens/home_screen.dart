import 'package:citizen/exports.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final reports = context.select<ReportsProvider, List<Report>>((p) => p.reports);
    final width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              spacing: 40,
              children: [
                const WelcomeWidget(),
                // Nearby Issues
                SizedBox(
                  width: width * 0.9,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Text(
                          'Nearby Issues',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Scrollable List of Nearby Issues
                      _NearbyIssuesList(reports: reports),
                    ],
                  ),
                ),
                // Stats Card
                const _StatsSection(),
              ],
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 140)),
        ],
      ),
    );
  }
}

class _NearbyIssuesList extends StatelessWidget {
  final List<Report> reports;
  const _NearbyIssuesList({required this.reports});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      clipBehavior: Clip.none,
      child: Row(
        spacing: 16,
        children: reports.take(5).map((report) {
          return IssueCard(report: report);
        }).toList(),
      ),
    );
  }
}

class _StatsSection extends StatelessWidget {
  const _StatsSection();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        spacing: 16,
        children: [
          StatsCardWidget(
            width: double.infinity,
            icon: Icons.warning_rounded,
            statNum: '95k+',
            text: 'TOTAL HELPED',
            color: AppColors.primary,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            spacing: 16,
            children: [
              Expanded(
                child: StatsCardWidget(
                  width: double.infinity,
                  icon: Icons.check_circle_rounded,
                  statNum: '45k+',
                  text: 'ISSUES FIXED',
                  color: AppColors.success,
                ),
              ),
              Expanded(
                child: StatsCardWidget(
                  width: double.infinity,
                  icon: Icons.people_rounded,
                  statNum: '25k',
                  text: 'CITIZENS',
                  color: AppColors.warning,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
