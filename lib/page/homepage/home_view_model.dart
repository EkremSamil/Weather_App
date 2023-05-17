import '../../../export.dart';
import 'package:http/http.dart' as http;

class HomeViewModel with ChangeNotifier {
  WeatherData _weatherData = WeatherData();

  HomeViewModel() {
    _weatherData = WeatherData();
    _getLocationData();
  }

  WeatherData get weatherData => _weatherData;

  Future<void> _getWeatherData(latLong) async {
    try {
      var url = '$base_url?key=$apiKey&q=$latLong&aqi=no';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        _weatherData = WeatherData.fromJson(jsonData);
        notifyListeners();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Failed to load data');
    }
  }

  Future<void> _getLocationData() async {
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
      if (position.latitude != null && position.longitude != null) {
        var latLong = ("${position.latitude}" ',' "${position.longitude}");

        await _getWeatherData(latLong);
      }
    } catch (e) {
      throw Exception('Failed to get location data');
    }
  }
}
