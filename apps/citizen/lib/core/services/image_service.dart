import 'dart:ui' as ui;
import 'package:citizen/exports.dart';

class ImageService {
  ImageService._();

  static final ImagePicker _picker = ImagePicker();

  /// Picks a single image from the specified [source] and processes it.
  static Future<File?> pickAndProcessImage({
    required ImageSource source,
  }) async {
    final XFile? pickedFile = await _picker.pickImage(
      source: source,
      imageQuality: 90,
    );

    if (pickedFile == null) return null;

    return await processImage(pickedFile);
  }

  /// Picks a profile image and forces a square crop.
  static Future<File?> pickProfileImage({required ImageSource source}) async {
    final XFile? pickedFile = await _picker.pickImage(
      source: source,
      imageQuality: 90,
    );

    if (pickedFile == null) return null;

    return await _pickProfileImage(pickedFile.path);
  }

  /// Picks multiple images from the gallery and processes each one.
  static Future<List<File>> pickAndProcessMultiImage({
    required int maxImages,
  }) async {
    final List<XFile> pickedFiles = await _picker.pickMultiImage(
      imageQuality: 90,
    );

    if (pickedFiles.isEmpty) return [];

    final List<File> processedImages = [];

    // Process only up to the remaining allowed count
    for (
      var i = 0;
      i < pickedFiles.length && processedImages.length < maxImages;
      i++
    ) {
      final processed = await processImage(pickedFiles[i]);
      if (processed != null) {
        processedImages.add(processed);
      }
    }

    return processedImages;
  }

  /// Processes an image: accepts landscape immediately, forces crop for portrait.
  static Future<File?> processImage(XFile pickedFile) async {
    final bytes = await pickedFile.readAsBytes();
    final ui.Codec codec = await ui.instantiateImageCodec(bytes);
    final ui.FrameInfo frameInfo = await codec.getNextFrame();
    final ui.Image image = frameInfo.image;

    if (image.width >= image.height) {
      // Landscape or Square: Accept as is
      return File(pickedFile.path);
    } else {
      // Portrait: Open Cropper for 16:9 Landscape aspect ratio
      return await _cropToLandscape(pickedFile.path);
    }
  }

  /// Internal helper to open the cropper with fixed 16:9 ratio.
  static Future<File?> _cropToLandscape(String path) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: path,
      aspectRatio: const CropAspectRatio(ratioX: 16, ratioY: 9),
      compressQuality: 90,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop to Landscape (16:9)',
          toolbarColor: AppColors.primary,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.ratio16x9,
          lockAspectRatio: true,
          hideBottomControls: true, // User shouldn't change settings
        ),
        IOSUiSettings(
          title: 'Crop to Landscape (16:9)',
          aspectRatioLockEnabled: true,
          resetAspectRatioEnabled: false,
          aspectRatioPickerButtonHidden: true,
        ),
      ],
    );

    if (croppedFile == null) return null;
    return File(croppedFile.path);
  }

  static Future<File?> _pickProfileImage(String path) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      compressQuality: 90,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Profile Picture',
          toolbarColor: AppColors.primary,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: true,
          hideBottomControls: true,
        ),
        IOSUiSettings(
          title: 'Crop Profile Picture',
          aspectRatioLockEnabled: true,
          resetAspectRatioEnabled: false,
          aspectRatioPickerButtonHidden: true,
        ),
      ],
    );

    if (croppedFile == null) return null;
    return File(croppedFile.path);
  }
}
