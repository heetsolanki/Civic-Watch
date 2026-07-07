import 'package:citizen/exports.dart';

class DescriptionField extends StatelessWidget {
  final String value;
  final ValueChanged<String> onChanged;

  const DescriptionField({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Description *',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            Text(
              '${value.length}/500',
              style: GoogleFonts.openSans(
                fontSize: 12,
                color: value.isNotEmpty && value.length < 20
                    ? AppColors.danger
                    : AppColors.textSecondary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: value.isNotEmpty && value.length < 20
                  ? AppColors.danger
                  : AppColors.primary.withOpacity(0.2),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: TextField(
            maxLines: 6,
            maxLength: 500,
            onChanged: onChanged,
            style: GoogleFonts.openSans(
              fontSize: 15,
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
            decoration: InputDecoration(
              counterText: "",
              hintText:
                  'Describe the issue...\n\nExample: "There is a large pothole near ABC School. It becomes filled with water during rain and is causing accidents."',
              hintStyle: GoogleFonts.openSans(
                color: Colors.grey.shade400,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
              contentPadding: const EdgeInsets.all(16),
              border: InputBorder.none,
            ),
          ),
        ),
        if (value.isNotEmpty && value.length < 20)
          Padding(
            padding: const EdgeInsets.only(top: 6, left: 4),
            child: Text(
              'Please provide at least 20 characters.',
              style: GoogleFonts.openSans(
                color: AppColors.danger,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
      ],
    );
  }
}
