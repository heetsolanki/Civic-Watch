import 'package:citizen/exports.dart';

class ReviewPhotosGallery extends StatelessWidget {
  final List<File> images;

  const ReviewPhotosGallery({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        physics: const BouncingScrollPhysics(),
        separatorBuilder: (_, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.file(
              images[index],
              width: 250,
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}
