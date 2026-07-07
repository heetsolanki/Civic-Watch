import 'package:citizen/exports.dart';
import 'package:url_launcher/url_launcher.dart';

class LaunchFunctions {
  static Future<void> launchEmail(String email) async {
    final Uri emailUri = Uri(scheme: 'mailto', path: email);

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    }
  }

  static Future<void> launchPhone(String phone) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phone);

    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    }
  }

  static Future<void> launchGithub(String github) async {
    final Uri githubUri = Uri.parse(github);

    if (await canLaunchUrl(githubUri)) {
      await launchUrl(githubUri, mode: LaunchMode.externalApplication);
    }
  }

  static Future<void> launchLinkedIn(String linkedIn) async {
    final Uri githubUri = Uri.parse(linkedIn);

    if (await canLaunchUrl(githubUri)) {
      await launchUrl(githubUri, mode: LaunchMode.externalApplication);
    }
  }
}
