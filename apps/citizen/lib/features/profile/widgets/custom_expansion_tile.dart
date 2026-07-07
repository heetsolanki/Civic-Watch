import 'package:citizen/exports.dart';

class CustomExpansionTile extends StatelessWidget {
  final String title;
  final String content;
  final bool isExpanded;
  final ValueChanged<bool> onExpansionChanged;

  const CustomExpansionTile({
    super.key,
    required this.title,
    required this.content,
    required this.isExpanded,
    required this.onExpansionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isExpanded ? AppColors.primary : AppColors.primary.withOpacity(0.1),
          width: 1,
        ),
        boxShadow: isExpanded ? [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ] : [],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => onExpansionChanged(!isExpanded),
        child: AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 18,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: GoogleFonts.openSans(
                          fontSize: 16,
                          fontWeight: isExpanded ? FontWeight.bold : FontWeight.w600,
                          color: isExpanded ? AppColors.primary : AppColors.textPrimary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    AnimatedRotation(
                      turns: isExpanded ? 0.5 : 0,
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeInOut,
                      child: Icon(
                        Icons.keyboard_arrow_down_outlined,
                        color: isExpanded
                            ? AppColors.primary
                            : AppColors.textSecondary,
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ),
              if (isExpanded) ...[
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      content,
                      style: GoogleFonts.openSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textPrimary.withOpacity(0.8),
                        height: 1.6,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
