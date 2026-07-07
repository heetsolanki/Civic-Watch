class FaqData {
  final String title;
  final String content;

  const FaqData({required this.title, required this.content});
}

final faqDataList = [
  const FaqData(
    title: 'How do I report an issue?',
    content:
        'Tap the Raise Issue button from the home screen, upload photos, provide issue details, confirm the location, and submit your report.',
  ),
  const FaqData(
    title: 'Can I edit my report?',
    content:
        'Yes. Reports can be edited until they are reviewed by the concerned authority.',
  ),
  const FaqData(
    title: 'Why is my report not visible?',
    content:
        'Your report may still be processing or may have been removed if it violates our community guidelines.',
  ),
  const FaqData(
    title: 'How can I track my report?',
    content:
        'Open My Reports from your profile to view the latest status and updates.',
  ),
  const FaqData(
    title: 'Is my personal information shared?',
    content:
        'No. CivicWatch only shares the information necessary to process civic complaints. Your personal details remain protected according to our Privacy Policy.',
  ),
];
