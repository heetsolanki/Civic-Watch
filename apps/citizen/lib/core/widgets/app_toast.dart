import 'package:citizen/exports.dart';

enum ToastType { success, error, info }

class AppToast {
  static OverlayEntry? _overlayEntry;
  static bool _isShowing = false;

  static void success(BuildContext context, String message) {
    _show(context, message, ToastType.success);
  }

  static void error(BuildContext context, String message) {
    _show(context, message, ToastType.error);
  }

  static void info(BuildContext context, String message) {
    _show(context, message, ToastType.info);
  }

  static void _show(BuildContext context, String message, ToastType type) {
    if (_isShowing) {
      _overlayEntry?.remove();
      _isShowing = false;
    }

    Color mainColor;
    IconData icon;

    switch (type) {
      case ToastType.success:
        mainColor = AppColors.success;
        icon = Icons.check_circle_rounded;
        break;
      case ToastType.error:
        mainColor = AppColors.danger;
        icon = Icons.error_rounded;
        break;
      case ToastType.info:
        mainColor = AppColors.primary;
        icon = Icons.info_rounded;
        break;
    }

    _overlayEntry = OverlayEntry(
      builder: (context) => _ToastWidget(
        message: message,
        mainColor: mainColor,
        icon: icon,
        onDismiss: () {
          _overlayEntry?.remove();
          _overlayEntry = null;
          _isShowing = false;
        },
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
    _isShowing = true;
  }
}

class _ToastWidget extends StatefulWidget {
  final String message;
  final Color mainColor;
  final IconData icon;
  final VoidCallback onDismiss;

  const _ToastWidget({
    required this.message,
    required this.mainColor,
    required this.icon,
    required this.onDismiss,
  });

  @override
  State<_ToastWidget> createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<_ToastWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    ));

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _controller.forward();

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        _controller.reverse().then((value) => widget.onDismiss());
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 110, // Adjusted to be below a standard navbar
      left: 20,
      right: 20,
      child: Material(
        color: Colors.transparent,
        child: SlideTransition(
          position: _offsetAnimation,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  // Increased opacity (0.9 for background, 0.15 for tint) for visibility
                  color: Colors.white.withOpacity(0.95), 
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: widget.mainColor.withOpacity(0.3)),
                  boxShadow: [
                    BoxShadow(
                      color: widget.mainColor.withOpacity(0.2),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(widget.icon, color: widget.mainColor, size: 20),
                    const SizedBox(width: 12),
                    Flexible(
                      child: Text(
                        widget.message,
                        style: GoogleFonts.openSans(
                          color: AppColors.textPrimary, // Changed to primary text color for better contrast
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
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
