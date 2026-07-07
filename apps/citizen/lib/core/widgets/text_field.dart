import 'package:citizen/exports.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final String? hintText;
  final int? maxLines;
  final bool obscureText;
  final TextInputType keyboardType;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixIconPressed;
  final bool readOnly;

  const CustomTextField({
    super.key,
    this.controller,
    this.onChanged,
    this.hintText,
    this.maxLines,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixIconPressed,
    this.readOnly = false,
  });

  @override
  State<CustomTextField> createState() => CustomTextFieldState();
}

class CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.textPrimary),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        readOnly: widget.readOnly,
        controller: widget.controller,
        obscureText: widget.obscureText,
        maxLines: widget.maxLines ?? 1,
        keyboardType: widget.keyboardType,
        style: GoogleFonts.openSans(fontSize: 15, color: AppColors.textPrimary),
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: GoogleFonts.openSans(
            color: Colors.grey.shade600,
            fontSize: 15,
          ),
          prefixIcon: widget.prefixIcon != null
              ? Icon(widget.prefixIcon, color: AppColors.textPrimary, size: 20)
              : null,
          suffixIcon: widget.suffixIcon != null
              ? (widget.onSuffixIconPressed != null
                    ? IconButton(
                        icon: Icon(
                          widget.suffixIcon,
                          color: AppColors.textPrimary,
                          size: 20,
                        ),
                        onPressed: widget.onSuffixIconPressed,
                      )
                    : Icon(
                        widget.suffixIcon,
                        color: AppColors.textPrimary,
                        size: 20,
                      ))
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        ),
        onChanged: widget.onChanged,
      ),
    );
  }
}
