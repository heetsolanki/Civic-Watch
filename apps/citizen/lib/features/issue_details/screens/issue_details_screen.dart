import 'package:citizen/exports.dart';

class IssueDetailsScreen extends StatefulWidget {
  final String id;

  const IssueDetailsScreen({super.key, required this.id});

  @override
  State<IssueDetailsScreen> createState() => _IssueDetailsScreenState();
}

class _IssueDetailsScreenState extends State<IssueDetailsScreen> {
  String username = '';

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  void loadUser() async {
    final user = await AppPreferences.getUser();
    setState(() {
      username = user['username'] ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final reports = context.watch<ReportProvider>().reports;
    final report = reports.where((item) => item.id == widget.id).firstOrNull;

    if (report == null) {
      return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.background,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.close, size: 28),
            onPressed: () {
              HapticFeedback.lightImpact();
              context.pop();
            },
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline_rounded,
                size: 64,
                color: AppColors.textSecondary.withValues(alpha: 0.5),
              ),
              const SizedBox(height: 16),
              Text(
                'Report not found',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 24),
              AppButton(
                text: 'Go Back',
                width: 150,
                onPressed: () {
                  HapticFeedback.lightImpact();
                  context.pop();
                },
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, size: 28, color: AppColors.textPrimary),
          onPressed: () {
            HapticFeedback.lightImpact();
            context.pop();
          },
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
              // TODO: Implement share functionality
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
              ImageContainer(report: report)
                  .animate()
                  .fadeIn(duration: 400.ms)
                  .scale(begin: const Offset(0.95, 0.95)),
              const SizedBox(height: 24),
              CategoryStatusPill(
                report: report,
              ).animate().fadeIn(delay: 100.ms).slideX(begin: -0.1),
              const SizedBox(height: 16),
              InfoContainer(
                report: report,
              ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1),
              const SizedBox(height: 32),
              if (report.userId == username)
                SupportersContainer(
                  report: report,
                ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.1),
              const SizedBox(height: 32),
              ResolutionTracker(
                report: report,
              ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1),
              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }
}
