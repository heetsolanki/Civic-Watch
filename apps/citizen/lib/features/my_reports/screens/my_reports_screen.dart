import 'package:citizen/exports.dart';

class MyReportsScreen extends StatefulWidget {
  const MyReportsScreen({super.key});

  @override
  State<MyReportsScreen> createState() => _MyReportsScreenState();
}

class _MyReportsScreenState extends State<MyReportsScreen> {
  String userId = 'user_1';
  final filters = ['All', 'Reported', 'Verified', 'Assigned', 'Resolved'];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          children: [
            SizedBox(
              height: 75,
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 10),
                scrollDirection: Axis.horizontal,
                itemCount: filters.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    child: ChoiceChip(
                      selectedColor: AppColors.primary.withOpacity(0.5),
                      backgroundColor: AppColors.cardColor,
                      labelStyle: GoogleFonts.poppins(
                        color: _selectedIndex == index
                            ? Colors.white
                            : AppColors.textPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      label: Text(filters[index]),
                      selected: _selectedIndex == index,
                      onSelected: (selected) {
                        setState(() {
                          _selectedIndex = index;
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: Builder(
                builder: (context) {
                  final filteredIssues = issueDataList.where((issue) {
                    final matchUser = userId == issue.userId;
                    final matchStatus =
                        _selectedIndex == 0 ||
                        issue.status.toLowerCase() ==
                            filters[_selectedIndex].toLowerCase();
                    return matchUser && matchStatus;
                  }).toList();
                  if (filteredIssues.isEmpty) {
                    return const Center(child: Text('No reports found'));
                  }
                  return ListView.builder(
                    itemCount: filteredIssues.length,
                    itemBuilder: (context, index) {
                      final issue = filteredIssues[index];
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
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
