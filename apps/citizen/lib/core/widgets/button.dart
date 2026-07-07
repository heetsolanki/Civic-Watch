import 'package:citizen/exports.dart';

class AppButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;

  final bool isLoading;
  final String? loadingText;
  final double height;
  final double width;
  final double borderRadius;
  final Icon? prefixIcon;
  final Icon? suffixIcon;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.loadingText,
    this.height = 50,
    this.width = double.infinity,
    this.borderRadius = 12,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.prefixIcon,
    this.suffixIcon,
  });

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: widget.onPressed != null
          ? (_) => setState(() => _isPressed = true)
          : null,
      onTapUp: widget.onPressed != null
          ? (_) => setState(() => _isPressed = false)
          : null,
      onTapCancel: widget.onPressed != null
          ? () => setState(() => _isPressed = false)
          : null,
      child: AnimatedScale(
        scale: _isPressed ? 0.96 : 1.0,
        duration: const Duration(milliseconds: 120),
        child: SizedBox(
          height: widget.height,
          width: widget.width,
          child: ElevatedButton(
            onPressed: widget.isLoading ? null : widget.onPressed,
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                side: BorderSide(
                  color: widget.borderColor ?? Colors.transparent,
                  width: 1.0,
                ),
              ),
              padding: EdgeInsets.zero,
              backgroundColor: widget.backgroundColor ?? AppColors.primary,
              foregroundColor: widget.textColor ?? Colors.white,
            ),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: widget.isLoading
                  ? Row(
                      key: const ValueKey('loading'),
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              widget.textColor ?? Colors.white,
                            ),
                          ),
                        ),
                        if (widget.loadingText != null) ...[
                          const SizedBox(width: 10),
                          Text(
                            widget.loadingText!,
                            style: GoogleFonts.openSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: widget.textColor ?? Colors.white,
                            ),
                          ),
                        ],
                      ],
                    )
                  : Row(
                      key: const ValueKey('normal'),
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (widget.prefixIcon != null) ...[
                          widget.prefixIcon!,
                          const SizedBox(width: 10),
                        ],
                        Text(
                          widget.text,
                          style: GoogleFonts.openSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: widget.textColor ?? Colors.white,
                          ),
                        ),
                        if (widget.suffixIcon != null) ...[
                          widget.suffixIcon!,
                          const SizedBox(width: 10),
                        ],
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
