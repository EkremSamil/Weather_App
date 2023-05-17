import 'package:http/http.dart' as http;
import 'package:weather_app/export.dart';

String base_url = "http://api.weatherapi.com/v1/current.json";
String apiKey = "d404cf68c53f4b40a05135211231205";

class WeatherService with ChangeNotifier {
  WeatherData _weatherData = WeatherData();

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

  Future<Position> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
      return position;
    } catch (e) {
      throw Exception('Failed to get location data');
    }
  }

  Future<void> getWeatherDataFromCurrentLocation() async {
    try {
      Position position = await _getCurrentLocation();
      if (position.latitude != null && position.longitude != null) {
        var latLong = ("${position.latitude}" ',' "${position.longitude}");
        return _getWeatherData(latLong);
      }
    } catch (e) {
      throw Exception('Failed to get location data');
    }
  }

  Future<void> getWeatherDataFromLocation(String location) async {
    try {
      var latLong = location;
      return _getWeatherData(latLong);
    } catch (e) {
      throw Exception('Failed to load data');
    }
  }
}


// import 'package:http/http.dart' as http;
//
// import '../../export.dart';
//
// String _url = "http://api.weatherapi.com/v1/current.json";
// String _apiKey = "d404cf68c53f4b40a05135211231205";
//
// class WeatherService with ChangeNotifier {
//   WeatherData _weatherData = WeatherData();
//
//   WeatherData get weatherData => _weatherData;
//
//   Future<void> getWeatherData(latLong) async {
//     try {
//       var url = '$_url?key=$_apiKey&q=$latLong&aqi=no';
//       final response = await http.get(Uri.parse(url));
//
//       if (response.statusCode == 200) {
//         var jsonData = jsonDecode(response.body);
//         _weatherData = WeatherData.fromJson(jsonData);
//         notifyListeners();
//       } else {
//         throw Exception('Failed to load data');
//       }
//     } catch (e) {
//       throw Exception('Failed to load data');
//     }
//   }
//
//   Future<void> getLocationData(String latLong) async {
//     try {
//       Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
//       if (position.latitude != null && position.longitude != null) {
//         var latLong = ("${position.latitude}" ',' "${position.longitude}");
//
//         await getWeatherData(latLong);
//         notifyListeners();
//       }
//     } catch (e) {
//       throw Exception('Failed to get location data');
//     }
//   }
// }