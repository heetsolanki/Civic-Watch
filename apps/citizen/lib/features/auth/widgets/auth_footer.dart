import 'package:citizen/exports.dart';

class AuthFooter extends StatefulWidget {
  final String text;
  final String ctaText;
  final VoidCallback onTap;

  const AuthFooter({
    super.key,
    required this.text,
    required this.ctaText,
    required this.onTap,
  });

  @override
  State<AuthFooter> createState() => AuthFooterBar();
}

class AuthFooterBar extends State<AuthFooter> {
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 20,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Expanded(
              child: Divider(
                height: 15,
                thickness: 1.0,
                indent: 5,
                endIndent: 10,
              ),
            ),
            Text(widget.text, style: GoogleFonts.openSans(fontSize: 14)),
            GestureDetector(
              onTap: widget.onTap,
              child: Text(
                widget.ctaText,
                style: GoogleFonts.openSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
            ),
            const Expanded(
              child: Divider(
                height: 15,
                thickness: 1.0,
                indent: 10,
                endIndent: 5,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
