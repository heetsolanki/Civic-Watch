import 'package:citizen/exports.dart';

class IssuesScreen extends StatefulWidget {
  const IssuesScreen({super.key});

  @override
  State<IssuesScreen> createState() => IssuesScreenState();
}

class IssuesScreenState extends State<IssuesScreen> {
  final List<String> categories = [
    'All',
    'Roads',
    'Sanitation',
    'Infrastructure',
    'Environment',
    'Safety',
    'Utilities',
  ];
  String selectedCategory = 'All';
  String tappedCategory = '';
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: width * 0.85,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row
              const SizedBox(height: 60),
              Row(
                spacing: 5,
                children: [
                  Icon(
                    Icons.search,
                    size: 28,
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                  Text(
                    'Explore Issues',
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 35, top: 5),
                child: Text(
                  'Find and support issues around your city.',
                  style: GoogleFonts.openSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              // Search Bar
              AppSearchBar(
                hintText: 'Search by issue title or location...',
                onChanged: (value) {
                  setState(() {
                    searchQuery = value.toLowerCase();
                  });
                },
              ),
              const SizedBox(height: 30),
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
              const SizedBox(height: 20),
              // Issue Cards
              Expanded(
                child: Builder(
                  builder: (context) {
                    final filteredIssues = issueDataList.where((issue) {
                      final matchesCategory =
                          selectedCategory == 'All' ||
                          issue.category == selectedCategory;
                      final matchesSearch =
                          issue.title.toLowerCase().contains(searchQuery) ||
                          issue.location.toLowerCase().contains(searchQuery);
                      return matchesCategory && matchesSearch;
                    }).toList();

                    if (filteredIssues.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search_off,
                              size: 64,
                              color: Colors.grey.shade300,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'No issues found matching your search.',
                              style: GoogleFonts.openSans(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.only(top: 10, bottom: 100),
                      physics: const BouncingScrollPhysics(),
                      itemCount: filteredIssues.length,
                      itemBuilder: (context, index) {
                        final issue = filteredIssues[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 25),
                          child: IssueCard(issue: issue),
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
