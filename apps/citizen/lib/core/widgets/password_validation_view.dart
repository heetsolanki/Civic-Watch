import 'dart:async';
import 'package:citizen/exports.dart';

class PasswordValidationView extends StatefulWidget {
  final String password;
  const PasswordValidationView({super.key, required this.password});

  @override
  State<PasswordValidationView> createState() => _PasswordValidationViewState();
}

class _PasswordValidationViewState extends State<PasswordValidationView> {
  final Map<String, bool> _requirementsMet = {
    'One uppercase letter': false,
    'One lowercase letter': false,
    'One number': false,
    'One special character': false,
    'At least 8 characters': false,
  };

  final Map<String, bool> _recentlyMet = {};
  final Map<String, Timer?> _timers = {};

  @override
  void didUpdateWidget(PasswordValidationView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.password != oldWidget.password) {
      _checkRequirements();
    }
  }

  void _checkRequirements() {
    final p = widget.password;
    final updates = {
      'One uppercase letter': RegExp(r'[A-Z]').hasMatch(p),
      'One lowercase letter': RegExp(r'[a-z]').hasMatch(p),
      'One number': RegExp(r'[0-9]').hasMatch(p),
      'One special character': RegExp(r'[!@#\$&*~]').hasMatch(p),
      'At least 8 characters': p.length >= 8,
    };

    setState(() {
      updates.forEach((req, isMet) {
        bool wasMet = _requirementsMet[req] ?? false;
        
        if (isMet && !wasMet) {
          // Just became met
          _recentlyMet[req] = true;
          _timers[req]?.cancel();
          _timers[req] = Timer(const Duration(seconds: 1), () {
            if (mounted) {
              setState(() {
                _recentlyMet[req] = false;
              });
            }
          });
        } else if (!isMet) {
          // Not met anymore
          _recentlyMet[req] = false;
          _timers[req]?.cancel();
        }
        
        _requirementsMet[req] = isMet;
      });
    });
  }

  @override
  void dispose() {
    _timers.values.forEach((t) => t?.cancel());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.password.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _requirementsMet.entries.where((entry) {
        // Show if NOT met OR if JUST met (recentlyMet)
        return !entry.value || (_recentlyMet[entry.key] ?? false);
      }).map((entry) {
        final isMet = entry.value;
        return Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Row(
            children: [
              Icon(
                isMet ? Icons.check : Icons.cancel_outlined,
                size: 14,
                color: isMet ? Colors.green : Colors.red,
              ),
              const SizedBox(width: 8),
              Text(
                entry.key,
                style: GoogleFonts.openSans(
                  fontSize: 12,
                  color: isMet ? Colors.green : Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
