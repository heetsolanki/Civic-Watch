import 'package:citizen/exports.dart';

class TechPill extends StatefulWidget {
  final String text;

  const TechPill({
    super.key,
    required this.text,
  });

  @override
  State<TechPill> createState() => _TechPillState();
}

class _TechPillState extends State<TechPill> {
  bool _isHovered = false;
  bool _isPressed = false;

  bool get _isActive => _isHovered || _isPressed;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedScale(
        scale: _isActive ? 1.03 : 1.0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          constraints: const BoxConstraints(minHeight: 40, maxHeight: 44),
          decoration: BoxDecoration(
            color: _isActive ? AppColors.primary : AppColors.surface,
            borderRadius: BorderRadius.circular(999),
            border: Border.all(
              color: _isActive 
                  ? AppColors.primary 
                  : AppColors.primary.withOpacity(0.25),
              width: 1,
            ),
            boxShadow: _isActive ? [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.25),
                blurRadius: 14,
                spreadRadius: 1,
                offset: const Offset(0, 4),
              )
            ] : [],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {},
              onTapDown: (_) => setState(() => _isPressed = true),
              onTapUp: (_) => setState(() => _isPressed = false),
              onTapCancel: () => setState(() => _isPressed = false),
              borderRadius: BorderRadius.circular(999),
              highlightColor: Colors.transparent,
              splashColor: _isActive ? Colors.white.withOpacity(0.1) : AppColors.primary.withOpacity(0.1),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.text,
                      style: GoogleFonts.openSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: _isActive ? Colors.white : AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
