// packages
export 'dart:async';
export 'dart:io';
export 'dart:math';
export 'package:flutter/material.dart';
export 'package:flutter/services.dart';
export 'package:flutter_map/flutter_map.dart';
export 'package:flutter_map_animations/flutter_map_animations.dart';
export 'package:go_router/go_router.dart';
export 'package:google_fonts/google_fonts.dart';
export 'package:image_cropper/image_cropper.dart';
export 'package:image_picker/image_picker.dart';
export 'package:provider/provider.dart';
export 'package:shared_preferences/shared_preferences.dart';
export 'package:flutter_animate/flutter_animate.dart' hide ShimmerEffect;
export 'package:skeletonizer/skeletonizer.dart';
export 'package:animated_flip_counter/animated_flip_counter.dart';

// app
export 'app/app.dart';
export 'app/router.dart';
export 'app/theme.dart';

// core - constants & data
export 'core/constants/app_colors.dart';
export 'core/data/issue_data.dart';
export 'core/data/title_suggestions.dart';
export 'core/storage/app_preferences.dart';

// core - widgets
export 'core/widgets/app_search_bar.dart';
export 'core/widgets/app_toast.dart';
export 'core/widgets/button.dart';
export 'core/widgets/category_selector.dart';
export 'core/widgets/issue_card.dart';
export 'core/widgets/password_validation_view.dart';

// features - home
export 'features/home/screens/home_screen.dart';
export 'features/home/widgets/stats_card_widget.dart';
export 'features/home/widgets/welcome_widget.dart';

// features - onboarding
export 'features/onboarding/models/onboarding_item.dart';
export 'features/onboarding/screens/onboarding_screen.dart';
export 'features/onboarding/widgets/onboarding_page.dart';
export 'features/onboarding/widgets/onboarding_screen.dart';

// features - auth
export 'features/auth/screens/account_screen.dart';
export 'features/auth/widgets/auth_footer.dart';
export 'features/auth/widgets/auth_header.dart';
export 'core/widgets/text_field.dart';
export 'features/auth/widgets/login_form.dart';
export 'features/auth/widgets/register_form.dart';

// features - profile
export 'features/profile/screens/edit_profile_screen.dart';
export 'features/profile/screens/profile_screen.dart';
export 'features/profile/screens/preferences_screen.dart';
export 'features/profile/screens/help_support_screen.dart';
export 'features/profile/screens/privacy_policy_screen.dart';
export 'features/profile/screens/terms_conditions_screen.dart';
export 'features/profile/screens/about_screen.dart';
export 'features/profile/widgets/profile_header.dart';
export 'features/profile/widgets/profile_menu_tile.dart';
export 'features/profile/widgets/profile_section.dart';
export 'features/profile/widgets/profile_stat_card.dart';
export 'features/profile/widgets/custom_expansion_tile.dart';
export 'features/profile/widgets/bullet_item.dart';
export 'features/profile/widgets/section_header.dart';
export 'features/profile/widgets/info_card.dart';
export 'features/profile/widgets/tech_pill.dart';
export 'features/profile/widgets/policy_section.dart';

// features - report
export 'features/report/models/report_draft.dart';
export 'features/report/models/report_flow_mode.dart';
export 'features/report/screens/create_report_screen.dart';
export 'features/report/screens/report_success_screen.dart';
export 'features/report/services/location_search_service.dart';
export 'features/report/services/location_service.dart';
export 'features/report/steps/category_step.dart';
export 'features/report/steps/details_step.dart';
export 'features/report/steps/location_step.dart';
export 'features/report/steps/photo_step.dart';
export 'features/report/steps/review_step.dart';
export 'features/report/widgets/address_card.dart';
export 'features/report/widgets/custom_app_bar.dart';
export 'features/report/widgets/description_field.dart';
export 'features/report/widgets/map_container.dart';
export 'features/report/widgets/map_view.dart';
export 'features/report/widgets/review_chip.dart';
export 'features/report/widgets/review_details_content.dart';
export 'features/report/widgets/review_location_content.dart';
export 'features/report/widgets/review_photos_gallery.dart';
export 'features/report/widgets/review_section_card.dart';
export 'features/report/widgets/review_status_banner.dart';
export 'features/report/widgets/submitting_report_dialog.dart';
export 'features/report/widgets/title_field.dart';

// features - my reports
export 'features/my_reports/screens/my_reports_screen.dart';

// features - issues
export 'features/issues/screens/issues_screen.dart';

// features - issue details
export 'features/issue_details/screens/issue_details_screen.dart';

// features - shell
export 'features/shell/screens/main_shell.dart';
export 'features/shell/widgets/bottom_navbar.dart';

// features - splash
export 'features/splash/screens/splash_screen.dart';

// providers
export 'providers/auth_provider.dart';
