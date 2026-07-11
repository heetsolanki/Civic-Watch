import 'package:citizen/core/services/image_service.dart';
import 'package:citizen/exports.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  File? _selectedImage;
  bool _imageRemoved = false;

  String _initialName = '';
  String _initialUsername = '';
  String _initialPhone = '';
  String? _initialImagePath;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_onTextChanged);
    _phoneController.addListener(_onTextChanged);
    _usernameController.addListener(_onTextChanged);
    loadUser();
  }

  void _onTextChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    _nameController.removeListener(_onTextChanged);
    _phoneController.removeListener(_onTextChanged);
    _usernameController.removeListener(_onTextChanged);
    _nameController.dispose();
    _usernameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  bool _isSaving = false;

  void loadUser() async {
    final data = await AppPreferences.getUser();
    setState(() {
      _initialName = data['name'] ?? '';
      _initialUsername = data['username'] ?? '';
      _initialPhone = data['phone'] ?? '';
      _initialImagePath = data['imagePath'];

      _nameController.text = _initialName;
      _usernameController.text = _initialUsername;
      _phoneController.text = _initialPhone;
      _emailController.text = data['email'] ?? '';
    });
  }

  bool get _hasChanges {
    final imageChanged =
        _selectedImage != null || (_imageRemoved && _initialImagePath != null);
    return _nameController.text != _initialName ||
        _usernameController.text != _initialUsername ||
        _phoneController.text != _initialPhone ||
        imageChanged;
  }

  Future<void> _handleImagePick(ImageSource source) async {
    final processed = await ImageService.pickProfileImage(source: source);
    if (processed != null) {
      HapticFeedback.lightImpact();
      setState(() {
        _selectedImage = processed;
        _imageRemoved = false;
      });
    }
  }

  void _showImagePickerOptions() {
    HapticFeedback.lightImpact();
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Take Photo'),
              onTap: () {
                Navigator.pop(context);
                _handleImagePick(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choose from Gallery'),
              onTap: () {
                Navigator.pop(context);
                _handleImagePick(ImageSource.gallery);
              },
            ),
            if (_selectedImage != null ||
                (_initialImagePath != null && !_imageRemoved))
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: const Text(
                  'Remove Photo',
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () {
                  HapticFeedback.vibrate();
                  Navigator.pop(context);
                  setState(() {
                    _selectedImage = null;
                    _imageRemoved = true;
                  });
                },
              ),
            ListTile(
              leading: const Icon(Icons.close),
              title: const Text('Cancel'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    ImageProvider? imageProvider;
    if (!_imageRemoved) {
      if (_selectedImage != null) {
        imageProvider = FileImage(_selectedImage!);
      } else if (_initialImagePath != null && _initialImagePath!.isNotEmpty) {
        imageProvider = FileImage(File(_initialImagePath!));
      }
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(
          'Edit Profile',
          style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: _showImagePickerOptions,
                    child: Stack(
                      alignment: const Alignment(0.85, 0.85),
                      children: [
                        Hero(
                          tag: 'profile-avatar',
                          child: CircleAvatar(
                            radius: 70,
                            backgroundColor: AppColors.cardColor,
                            backgroundImage: imageProvider,
                            child: imageProvider == null
                                ? const Icon(
                                    Icons.person,
                                    size: 70,
                                    color: AppColors.textPrimary,
                                  )
                                : null,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 8,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.camera_alt_rounded,
                            size: 24,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .animate()
                .fadeIn(duration: 400.ms)
                .scale(begin: const Offset(0.9, 0.9)),
            const SizedBox(height: 16),
            AppButton(
              text: 'Change Photo',
              width: width * 0.45,
              height: 40,
              textColor: AppColors.primary,
              backgroundColor: Colors.white,
              borderColor: AppColors.primary.withOpacity(0.2),
              onPressed: _showImagePickerOptions,
            ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.2),
            const SizedBox(height: 40),
            CustomTextField(
              controller: _nameController,
              hintText: 'Full Name',
              prefixIcon: Icons.person_outline_rounded,
              keyboardType: TextInputType.text,
            ).animate().fadeIn(delay: 200.ms).slideX(begin: -0.1),
            const SizedBox(height: 20),
            CustomTextField(
              controller: _usernameController,
              hintText: 'Username',
              prefixIcon: Icons.alternate_email_rounded,
              keyboardType: TextInputType.text,
            ).animate().fadeIn(delay: 250.ms).slideX(begin: -0.1),
            const SizedBox(height: 20),
            CustomTextField(
              controller: _emailController,
              hintText: 'Email Address',
              prefixIcon: Icons.mail_outline_rounded,
              suffixIcon: Icons.lock_outline_rounded,
              readOnly: true,
            ).animate().fadeIn(delay: 300.ms).slideX(begin: -0.1),
            const SizedBox(height: 20),
            CustomTextField(
              controller: _phoneController,
              hintText: 'Phone Number',
              prefixIcon: Icons.phone_android_rounded,
              keyboardType: TextInputType.phone,
            ).animate().fadeIn(delay: 400.ms).slideX(begin: -0.1),
            const SizedBox(height: 80),
            AppButton(
              text: 'Save Changes',
              loadingText: 'Saving...',
              isLoading: _isSaving,
              backgroundColor: AppColors.primary,
              onPressed: (_hasChanges && _usernameController.text.isNotEmpty)
                  ? () async {
                      HapticFeedback.mediumImpact();
                      setState(() => _isSaving = true);
                      String? finalImagePath;
                      if (_imageRemoved) {
                        finalImagePath = '';
                      } else if (_selectedImage != null) {
                        finalImagePath = _selectedImage!.path;
                      }

                      await AppPreferences.updateUserProfile(
                        name: _nameController.text,
                        username: _usernameController.text,
                        phone: _phoneController.text,
                        imagePath: finalImagePath,
                      );

                      if (mounted) {
                        AppToast.success(
                          context,
                          'Profile Updated Successfully!',
                        );
                        context.pop(true);
                      }
                    }
                  : null,
            ).animate().fadeIn(delay: 500.ms),
          ],
        ),
      ),
    );
  }
}
