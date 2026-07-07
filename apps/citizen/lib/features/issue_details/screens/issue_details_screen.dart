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
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.keyboard_arrow_left_rounded,
            size: 28,
            color: AppColors.textPrimary,
          ),
          onPressed: () => context.go('/home'),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.share_rounded,
              color: AppColors.textPrimary,
              size: 22,
            ),
            onPressed: () {
              HapticFeedback.lightImpact();
            },
          ),
          const SizedBox(width: 8),
        ],
        toolbarHeight: 65,
        title: Text(
          'Issue Details',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImageContainer(issue: issue).animate().fadeIn(duration: 400.ms).scale(begin: const Offset(0.95, 0.95)),
              const SizedBox(height: 24),
              CategoryStatusPill(issue: issue).animate().fadeIn(delay: 100.ms).slideX(begin: -0.1),
              const SizedBox(height: 16),
              InfoContainer(issue: issue).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1),
              const SizedBox(height: 32),
              SupportersContainer(issue: issue).animate().fadeIn(delay: 300.ms).slideY(begin: 0.1),
              const SizedBox(height: 32),
              ResolutionTracker(issue: issue).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1),
              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }
}
