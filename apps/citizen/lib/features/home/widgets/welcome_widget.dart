import 'package:citizen/exports.dart';

class WelcomeWidget extends StatefulWidget {
  const WelcomeWidget({super.key});

  @override
  State<WelcomeWidget> createState() => WelcomeWidgetScreen();
}

class WelcomeWidgetScreen extends State<WelcomeWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 25,
      children: [
        // Top trusted pill
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 50),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: AppColors.primary.withOpacity(0.5),
                ),
                height: 30,
                width: MediaQuery.of(context).size.width * 0.60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(width: 5),
                    Icon(
                      Icons.health_and_safety,
                      color: AppColors.textPrimary,
                      size: 22,
                    ),
                    Text(
                      'Trusted by many people',
                      style: GoogleFonts.openSans(
                        fontSize: 14,
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 5),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Hero Section & CTA button
        Column(
          spacing: 30.0,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text Column
            Column(
              spacing: 2.0,
              children: [
                Text(
                  textAlign: TextAlign.center,
                  'Report Issues.\nEmpower Communities.',
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  textAlign: TextAlign.center,
                  'Build Better Cities.',
                  style: GoogleFonts.poppins(
                    color: AppColors.textPrimary,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30.0,
                    vertical: 10.0,
                  ),
                  child: Text(
                    'Join a modern network of citizens and local governments working together to maintain and improve civic infrastructure.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.openSans(fontSize: 15),
                  ),
                ),
              ],
            ),
            // CTA buttons
            Column(
              spacing: 20,
              children: [
                AppButton(
                  text: 'Report Issue',
                  onPressed: () {
                    context.go('/create-report');
                  },
                  width: MediaQuery.of(context).size.width * 0.85,
                  backgroundColor: AppColors.textPrimary,
                  prefixIcon: Icon(Icons.add_circle_outline_rounded, size: 20),
                ),
                AppButton(
                  text: 'Explore Issues',
                  onPressed: () {
                    context.go('/explore-issues');
                  },
                  width: MediaQuery.of(context).size.width * 0.85,
                  backgroundColor: Colors.white,
                  borderColor: AppColors.textPrimary,
                  textColor: AppColors.textPrimary,
                  prefixIcon: Icon(Icons.search, size: 20),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
