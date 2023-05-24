import '../../../export.dart';
import 'package:http/http.dart' as http;

String base_url = "http://api.weatherapi.com/v1/forecast.json";
String apiKey = "d404cf68c53f4b40a05135211231205";

class WeatherDataFromAPI with ChangeNotifier {
  WeatherData? _weatherData = WeatherData();
  String _error = '';
  bool _loading = false;
  DateTime? _lastUpdated;

  WeatherDataFromAPI() {
    _weatherData = WeatherData();
    _lastUpdated = null;
    _getLocationData();
  }

  WeatherData? get weatherData => _weatherData;
  String get error => _error;
  bool get loading => _loading;

  Future<void> _getWeatherData(latLong) async {
    try {
      _loading = true;
      notifyListeners();

      // ignore: unnecessary_null_comparison
      if (_weatherData != null && _lastUpdated != null) {
        if (_lastUpdated!.isAfter(DateTime.now().subtract(Duration(minutes: 30)))) {
          _loading = false;
          notifyListeners();
          return;
        }
      }

      var url = '$base_url?key=$apiKey&q=$latLong&days=7&aqi=yes&alerts=no';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        _weatherData = WeatherData.fromJson(jsonData);
        _error = '';
        _lastUpdated = DateTime.now(); // Güncelleme zamanını kaydet
      } else {
        _error = 'Failed to load data';
      }
    } catch (e) {
      _error = 'Failed to load data';
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> _getLocationData() async {
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
      // ignore: unnecessary_null_comparison
      if (position.latitude != null && position.longitude != null) {
        var latLong = "${position.latitude},${position.longitude}";
        await _getWeatherData(latLong);
      }
    } catch (e) {
      _error = 'Failed to get location data';
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
