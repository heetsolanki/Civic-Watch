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

class _ToastWidgetState extends State<_ToastWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 1), // Slide up from bottom
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

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
      bottom: 50, // Changed to bottom
      left: 24,
      right: 24,
      child: Material(
        color: Colors.transparent,
        child: SlideTransition(
          position: _offsetAnimation,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: AppColors.cardColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: widget.mainColor.withOpacity(0.2)),
                  boxShadow: [
                    BoxShadow(
                      color: widget.mainColor.withOpacity(0.15),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: widget.mainColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        widget.icon,
                        color: widget.mainColor,
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Flexible(
                      child: Text(
                        widget.message,
                        style: GoogleFonts.openSans(
                          color: AppColors.textPrimary,
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
