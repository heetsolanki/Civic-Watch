import 'package:citizen/exports.dart';
import 'package:latlong2/latlong.dart';

typedef LocationChangedCallback =
    void Function(double latitude, double longitude, String address);

class MapContainer extends StatefulWidget {
  final Report report;
  final LocationChangedCallback onLocationChanged;

  const MapContainer({
    super.key,
    required this.report,
    required this.onLocationChanged,
  });

  @override
  State<MapContainer> createState() => _MapContainerState();
}

class _MapContainerState extends State<MapContainer>
    with TickerProviderStateMixin {
  late final AnimatedMapController _animatedMapController;
  bool _isLoadingLocation = true;
  LatLng? _selectedLocation;
  String? _selectedAddress;
  bool _isFetchingAddress = false;

  // Search State
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
  List<LocationSearchResult> _searchResults = [];
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _animatedMapController = AnimatedMapController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOutCubic,
      cancelPreviousAnimations: true,
    );

    if (widget.report.latitude != 0.0 && widget.report.longitude != 0.0) {
      _selectedLocation = LatLng(
        widget.report.latitude,
        widget.report.longitude,
      );
      _selectedAddress = widget.report.address;
      _isLoadingLocation = false;
      _setLocation(_selectedLocation!, animate: false);
    } else {
      _getCurrentLocation();
    }
  }

  @override
  void dispose() {
    _animatedMapController.dispose();
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  Future<void> _getCurrentLocation() async {
    final position = await LocationService.getCurrentPosition();

    if (!mounted) return;

    if (position != null) {
      _setLocation(LatLng(position.latitude, position.longitude));
    } else {
      setState(() => _isLoadingLocation = false);
    }
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () async {
      if (query.isEmpty) {
        setState(() {
          _searchResults = [];
          _isSearching = false;
        });
        return;
      }

      setState(() => _isSearching = true);
      final results = await LocationSearchService.search(query);
      if (!mounted) return;
      setState(() {
        _searchResults = results;
        _isSearching = false;
      });
    });
  }

  Future<void> _setLocation(LatLng point, {bool animate = true}) async {
    setState(() {
      _selectedLocation = point;
      _isLoadingLocation = false;
      _selectedAddress = null;
      _isFetchingAddress = true;
      _searchResults = [];
      _searchController.clear();
    });

    if (animate) {
      _animatedMapController.animateTo(dest: point);
    }

    final address = await LocationService.reverseGeocode(point);
    final finalAddress = address ?? 'Location selected';

    if (!mounted) return;

    setState(() {
      _selectedAddress = finalAddress;
      _isFetchingAddress = false;
    });

    widget.onLocationChanged(point.latitude, point.longitude, finalAddress);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: (_isLoadingLocation || _selectedLocation == null)
          ? _LoadingLocationView()
          : Column(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      MapView(
                        animatedMapController: _animatedMapController,
                        selectedLocation: _selectedLocation!,
                        onTap: _setLocation,
                      ),
                      Positioned(
                        top: 15,
                        left: 15,
                        right: 15,
                        child: Column(
                          children: [
                            AppSearchBar(
                              controller: _searchController,
                              hintText: 'Search location...',
                              onChanged: _onSearchChanged,
                              suffixIcon: _isSearching
                                  ? const Padding(
                                      padding: EdgeInsets.all(12.0),
                                      child: SizedBox(
                                        width: 16,
                                        height: 16,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                    )
                                  : null,
                            ),
                            if (_searchResults.isNotEmpty)
                              Container(
                                margin: const EdgeInsets.only(top: 8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: ListView.separated(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: _searchResults.length,
                                  separatorBuilder: (context, index) =>
                                      const Divider(height: 1),
                                  itemBuilder: (context, index) {
                                    final result = _searchResults[index];
                                    return ListTile(
                                      leading: const Icon(
                                        Icons.location_on_outlined,
                                        color: AppColors.primary,
                                        size: 20,
                                      ),
                                      title: Text(
                                        result.displayName,
                                        style: GoogleFonts.openSans(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      onTap: () =>
                                          _setLocation(result.location),
                                    );
                                  },
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                AddressCard(
                  address: _selectedAddress,
                  isLoading: _isFetchingAddress,
                ),
              ],
            ),
    );
  }
}

class _LoadingLocationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.location_searching,
            size: 50,
            color: AppColors.primary,
          ),
          const SizedBox(height: 20),
          const CircularProgressIndicator(color: AppColors.primary),
          const SizedBox(height: 20),
          Text(
            'Getting your location...',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Please wait while we fetch your coordinates.',
            style: GoogleFonts.openSans(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
