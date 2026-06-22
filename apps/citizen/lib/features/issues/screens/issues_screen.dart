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
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            SizedBox(height: 20),
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
              padding: EdgeInsets.symmetric(horizontal: 35, vertical: 5),
              child: Text(
                'Find and support issues around your city.',
                style: GoogleFonts.openSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 30,),
            // Search Bar
            AppSearchBar(
              hintText: 'Search by issue title or location...',
              onChanged: (value) {
                setState(() {
                  searchQuery = value.toLowerCase();
                });
              },
            ),
            SizedBox(height: 30),
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
            SizedBox(height: 20),
            // Issue Cards
            Expanded(
              child: Builder(
                builder: (context) {
                  final filteredIssues = issueDataList.where((issue) {
                    final matchesCategory = selectedCategory == 'All' ||
                        issue.category == selectedCategory;
                    final matchesSearch = issue.title
                            .toLowerCase()
                            .contains(searchQuery) ||
                        issue.location.toLowerCase().contains(searchQuery);
                    return matchesCategory && matchesSearch;
                  }).toList();

                  if (filteredIssues.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search_off,
                              size: 64, color: Colors.grey.shade300),
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
                    physics: const BouncingScrollPhysics(),
                    itemCount: filteredIssues.length,
                    itemBuilder: (context, index) {
                      final issue = filteredIssues[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 15),
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
    );
  }
}
