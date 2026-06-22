import 'package:citizen/exports.dart';
import 'package:citizen/features/home/data/issue_data.dart';
import 'package:citizen/features/home/widgets/stats_card_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              spacing: 40,
              children: [
                WelcomeWidget(),
                // Nearby Issues
                SizedBox(
                  width: width * 0.85,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nearby Issues',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Scrollable List of Nearby Issues
                      SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        clipBehavior: Clip.none,
                        child: Row(
                          spacing: 16,
                          children: issueDataList.map((issue) {
                            return IssueCard(issue: issue);
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
                // Stats Card
                Column(
                  spacing: 20,
                  children: [
                    StatsCardWidget(
                      width: width * 0.85,
                      icon: Icons.warning,
                      statNum: '95k+',
                      text: 'TOTAL HELPED',
                      color: AppColors.textPrimary,
                    ),
                    SizedBox(
                      width: width * 0.85,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          StatsCardWidget(
                            width: width * 0.40,
                            icon: Icons.check_circle,
                            statNum: '45k+',
                            text: 'ISSUES FIXED',
                            color: AppColors.smallText,
                          ),
                          StatsCardWidget(
                            width: width * 0.40,
                            icon: Icons.people,
                            statNum: '25k',
                            text: 'ACTIVE CITIZENS',
                            color: Colors.amber,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 150)),
        ],
      ),
    );
  }
}
