import '../export.dart';

class LocationService with ChangeNotifier {
  late Position _position;

  Position get position => _position;

  Future<void> getCurrentLocation() async {
    try {
      _position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to get location data');
    }
  }

  String getLatLong() {
    return "${_position.latitude},${_position.longitude}";
  }
}
