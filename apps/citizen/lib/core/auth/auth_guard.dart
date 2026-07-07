import 'package:citizen/exports.dart';

Future<bool> requireLogin(BuildContext context, {String? message}) async {
  final isLoggedIn = await AppPreferences.isLoggedIn();

  if (isLoggedIn) return true;

  if (context.mounted) {
    AppToast.info(
      context,
      message ?? 'You are not logged in. Please log in to continue.',
    );
  }

  return false;
}
