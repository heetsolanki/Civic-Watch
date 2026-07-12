import 'package:citizen/exports.dart';

class IssuesScreen extends StatefulWidget {
  const IssuesScreen({super.key});

  @override
  State<IssuesScreen> createState() => IssuesScreenState();
}

class IssuesScreenState extends State<IssuesScreen> {
  static const List<String> categories = [
    'All',
    'Roads',
    'Utilities',
    'Cleanliness',
    'Environment',
    'Public Property',
    'Traffic & Parking',
    'Public Transport',
    'Construction',
    'Animals',
    'Public Safety',
    'Other',
  ];
  String selectedCategory = 'All';
  String tappedCategory = '';
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final reports = context.watch<ReportsProvider>().reports;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: SizedBox(
          width: width * 0.9,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),
              // Search Bar
              AppSearchBar(
                hintText: 'Search by issue title or location...',
                onChanged: (value) {
                  setState(() {
                    searchQuery = value.toLowerCase();
                  });
                },
              ),
              const SizedBox(height: 24),
              // Categories Pill
              CategorySelector(
                categories: categories,
                selectedCategory: selectedCategory,
                onCategorySelected: (category) {
                  setState(() {
                    selectedCategory = category;
                  });
                },
              ),
              const SizedBox(height: 24),
              // Issue Cards
              Expanded(
                child: Builder(
                  builder: (context) {
                    final filteredReports = reports.where((report) {
                      final matchesCategory =
                          selectedCategory == 'All' ||
                          report.category == selectedCategory;
                      final matchesSearch =
                          report.title.toLowerCase().contains(searchQuery) ||
                          report.address.toLowerCase().contains(searchQuery);
                      return matchesCategory && matchesSearch;
                    }).toList();

                    if (filteredReports.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search_off_rounded,
                              size: 72,
                              color: AppColors.primary.withOpacity(0.1),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'No issues found matching your search.',
                              style: GoogleFonts.openSans(
                                color: AppColors.textSecondary,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.only(top: 10, bottom: 100),
                      physics: const BouncingScrollPhysics(),
                      itemCount: filteredReports.length,
                      itemBuilder: (context, index) {
                        final report = filteredReports[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 24),
                          child: Center(child: IssueCard(report: report)),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
