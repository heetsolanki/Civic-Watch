import 'package:citizen/exports.dart';

class PreferencesScreen extends StatefulWidget {
  const PreferencesScreen({super.key});

  @override
  State<PreferencesScreen> createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferencesScreen> {
  bool _appNotifications = false;
  bool _reportUpdates = true;
  bool _authorityMessages = true;
  bool _nearbyIssues = true;
  bool _isLoading = true;
  bool _isSaving = false;

  bool _initialAppNotifications = false;
  bool _initialReportUpdates = true;
  bool _initialAuthorityMessages = true;
  bool _initialNearbyIssues = true;

  @override
  void initState() {
    super.initState();
    loadNotifications();
  }

  void loadNotifications() async {
    final data = await AppPreferences.getUser();
    setState(() {
      _appNotifications = data['appNotifications'] ?? false;
      _reportUpdates = data['reportUpdates'] ?? true;
      _authorityMessages = data['authorityMessages'] ?? true;
      _nearbyIssues = data['nearbyIssues'] ?? true;

      _initialAppNotifications = _appNotifications;
      _initialReportUpdates = _reportUpdates;
      _initialAuthorityMessages = _authorityMessages;
      _initialNearbyIssues = _nearbyIssues;
      _isLoading = false;
    });
  }

  bool get _hasChanges {
    return _appNotifications != _initialAppNotifications ||
        _reportUpdates != _initialReportUpdates ||
        _authorityMessages != _initialAuthorityMessages ||
        _nearbyIssues != _initialNearbyIssues;
  }

  Future<void> _savePreferences() async {
    HapticFeedback.mediumImpact();
    setState(() => _isSaving = true);
    await AppPreferences.updatePreferences(
      appNotifications: _appNotifications,
      reportUpdates: _reportUpdates,
      authorityMessages: _authorityMessages,
      nearbyIssues: _nearbyIssues,
    );
    if (mounted) {
      AppToast.success(context, 'Preferences Saved Successfully!');
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(
          'Preferences',
          style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(title: 'Push Notifications'),
            InfoCard(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: SizedBox(
                width: width * 0.85,
                child: Column(
                  children: [
                    ProfileMenuTile(
                      label: 'App Notifications',
                      icon: Icons.notifications_none_rounded,
                      trailing: Switch(
                        activeThumbColor: AppColors.primary,
                        activeTrackColor: AppColors.primary.withOpacity(0.2),
                        value: _appNotifications,
                        onChanged: (value) {
                          HapticFeedback.selectionClick();
                          setState(() => _appNotifications = value);
                        },
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.1),
            const SizedBox(height: 32),
            const SectionHeader(title: 'Notification Categories'),
            InfoCard(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: SizedBox(
                width: width * 0.85,
                child: Column(
                  children: [
                    ProfileMenuTile(
                      label: 'Report Updates',
                      icon: Icons.update_rounded,
                      trailing: Switch(
                        activeThumbColor: AppColors.primary,
                        activeTrackColor: AppColors.primary.withOpacity(0.2),
                        value: _reportUpdates,
                        onChanged: (value) {
                          HapticFeedback.selectionClick();
                          setState(() => _reportUpdates = value);
                        },
                      ),
                      onTap: () {},
                    ),
                    const Divider(indent: 70, endIndent: 20, thickness: 0.5),
                    ProfileMenuTile(
                      label: 'Authority Messages',
                      icon: Icons.account_balance_rounded,
                      trailing: Switch(
                        activeThumbColor: AppColors.primary,
                        activeTrackColor: AppColors.primary.withOpacity(0.2),
                        value: _authorityMessages,
                        onChanged: (value) {
                          HapticFeedback.selectionClick();
                          setState(() => _authorityMessages = value);
                        },
                      ),
                      onTap: () {},
                    ),
                    const Divider(indent: 70, endIndent: 20, thickness: 0.5),
                    ProfileMenuTile(
                      label: 'Nearby Issues',
                      icon: Icons.location_on_outlined,
                      trailing: Switch(
                        activeThumbColor: AppColors.primary,
                        activeTrackColor: AppColors.primary.withOpacity(0.2),
                        value: _nearbyIssues,
                        onChanged: (value) {
                          HapticFeedback.selectionClick();
                          setState(() => _nearbyIssues = value);
                        },
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.1),
            const SizedBox(height: 100),
            AppButton(
              text: 'Save Preferences',
              loadingText: 'Saving...',
              isLoading: _isSaving,
              backgroundColor: AppColors.primary,
              onPressed: _hasChanges ? _savePreferences : null,
            ).animate().fadeIn(delay: 400.ms),
          ],
        ),
      ),
    );
  }
}
