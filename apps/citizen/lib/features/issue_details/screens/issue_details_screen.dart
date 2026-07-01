import 'package:citizen/exports.dart';
import 'package:citizen/features/issue_details/widgets/category_status_pill.dart';
import 'package:citizen/features/issue_details/widgets/image_container.dart';
import 'package:citizen/features/issue_details/widgets/info_container.dart';
import 'package:citizen/features/issue_details/widgets/resolution_tracker.dart';
import 'package:citizen/features/issue_details/widgets/supporters_container.dart';

class IssueDetailsScreen extends StatefulWidget {
  final String issueId;

  const IssueDetailsScreen({super.key, required this.issueId});

  @override
  State<IssueDetailsScreen> createState() => _IssueDetailsScreenState();
}

class _IssueDetailsScreenState extends State<IssueDetailsScreen> {

  @override
  Widget build(BuildContext context) {
    final issue = issueDataList.firstWhere((item) => item.id == widget.issueId);

    return Scaffold(
      backgroundColor: const Color(0xfff8f9ff),
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.keyboard_arrow_left,
            size: 25,
            color: AppColors.textPrimary,
          ),
          onPressed: () {
            context.go('/home');
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.share_outlined,
              color: AppColors.textPrimary,
            ),
            onPressed: () {},
          ),
        ],
        toolbarHeight: 65,
        elevation: 5,
        title: Text(
          'View Details',
          style: GoogleFonts.poppins(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImageContainer(issue: issue),
              const SizedBox(height: 20),
              CategoryStatusPill(issue: issue),
              const SizedBox(height: 10),
              InfoContainer(issue: issue),
              const SizedBox(height: 40),
              SupportersContainer(issue: issue),
              const SizedBox(height: 40),
              ResolutionTracker(issue: issue),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
