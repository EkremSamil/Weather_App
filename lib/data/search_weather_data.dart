import '../export.dart';
import 'package:http/http.dart' as http;

class WeatherSearchData extends ChangeNotifier {
  WeatherData _weatherData = WeatherData();
  String _error = '';
  bool _loading = false;
  // ignore: unused_field
  DateTime? _lastUpdated;
  List<String> _searchHistory = [];
  List<WeatherData> _searchResults = [];

  List<WeatherData> get searchResults => _searchResults;
  WeatherData get weatherData => _weatherData;
  String get error => _error;
  bool get loading => _loading;
  List<String> get searchHistory => _searchHistory;

  Future<void> searchWeatherData(String searchText) async {
    try {
      _loading = true;
      notifyListeners();

      var url =
          'http://api.weatherapi.com/v1/forecast.json?key=d404cf68c53f4b40a05135211231205&q=$searchText&days=1&aqi=no&alerts=no';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        _weatherData = WeatherData.fromJson(jsonData);
        _error = '';
        _lastUpdated = DateTime.now();
        _searchResults.add(weatherData);

        _searchHistory.add(searchText);
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
}
