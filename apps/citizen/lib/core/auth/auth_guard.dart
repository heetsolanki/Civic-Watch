import 'package:citizen/exports.dart';

Future<bool> requireLogin(BuildContext context) async {
  final isLoggedIn = await AppPreferences.isLoggedIn();

  if (isLoggedIn) return true;

  final result = await context.push<bool>('/auth', extra: false);

  return result ?? false;
}
