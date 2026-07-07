import 'package:citizen/exports.dart';
import 'package:citizen/core/data/title_suggestions.dart';

class TitleField extends StatefulWidget {
  final String category;
  final String value;
  final ValueChanged<String> onChanged;

  const TitleField({
    super.key,
    required this.category,
    required this.value,
    required this.onChanged,
  });

  @override
  State<TitleField> createState() => _TitleFieldState();
}

class _TitleFieldState extends State<TitleField> {
  late final TextEditingController _controller;
  bool _showSuggestions = true;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value);
    _controller.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    final suggestions = categoryTitleSuggestions[widget.category] ?? [];
    if (_controller.text.isNotEmpty &&
        !suggestions.contains(_controller.text)) {
      if (_showSuggestions) {
        setState(() => _showSuggestions = false);
      }
    } else if (_controller.text.isEmpty) {
      if (!_showSuggestions) {
        setState(() => _showSuggestions = true);
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final suggestions = categoryTitleSuggestions[widget.category] ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Issue Title *',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            Text(
              '${widget.value.length}/100',
              style: GoogleFonts.openSans(
                fontSize: 12,
                color: widget.value.isNotEmpty && widget.value.length < 10
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
              color: widget.value.isNotEmpty && widget.value.length < 10
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
            controller: _controller,
            maxLength: 100,
            onChanged: widget.onChanged,
            style: GoogleFonts.openSans(
              fontSize: 15,
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
            decoration: InputDecoration(
              counterText: "",
              hintText: 'e.g., Large pothole near City Mall',
              hintStyle: GoogleFonts.openSans(
                color: Colors.grey.shade400,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 15,
              ),
              border: InputBorder.none,
            ),
          ),
        ),
        if (widget.value.isNotEmpty && widget.value.length < 10)
          Padding(
            padding: const EdgeInsets.only(top: 6, left: 4),
            child: Text(
              'Please provide at least 10 characters.',
              style: GoogleFonts.openSans(
                color: AppColors.danger,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

        if (_showSuggestions && suggestions.isNotEmpty) ...[
          const SizedBox(height: 20),
          Text(
            'Suggestions',
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: suggestions.map((suggestion) {
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: ActionChip(
                    label: Text(suggestion),
                    labelStyle: GoogleFonts.openSans(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                    backgroundColor: AppColors.primary.withOpacity(0.05),
                    side: BorderSide(color: AppColors.primary.withOpacity(0.1)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    onPressed: () {
                      HapticFeedback.selectionClick();
                      _controller.text = suggestion;
                      widget.onChanged(suggestion);
                      setState(() => _showSuggestions = false);
                    },
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ],
    );
  }
}
