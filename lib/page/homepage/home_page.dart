import 'package:provider/provider.dart';
import 'package:weather_app/component/homePageTabBarItems.dart';
import 'package:weather_app/export.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    TextTheme darkTextTheme = WeatherAppTheme.darkTextTheme;
    return ChangeNotifierProvider(
      create: (_) => HomeViewModel(),
      child: Scaffold(
        body: Stack(
          children: [
            Image.asset(
              backGroundPage,
              fit: BoxFit.cover,
              width: screenWidth,
              height: screenHeight,
            ),
            Center(
              child: Consumer<HomeViewModel>(
                builder: (context, model, child) {
                  return model.weatherData == null
                      ? const CircularProgressIndicator()
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "${model.weatherData.location?.name}",
                              style: darkTextTheme.bodyLarge,
                            ),
                            Text(
                              "${model.weatherData.current?.temp_c}°",
                              style: darkTextTheme.bodyLarge,
                            ),
                            Text(
                              "${model.weatherData.current?.condition.text}",
                              style: darkTextTheme.bodyMedium?.copyWith(
                                color: Colors.white60,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Nem : ${model.weatherData.current?.humidity}%",
                                  style: darkTextTheme.bodyMedium?.copyWith(
                                    color: Colors.white60,
                                  ),
                                ),
                              ],
                            ),
                            SvgPicture.asset(
                              house,
                              fit: BoxFit.cover,
                              width: screenWidth / 2.5,
                              height: screenHeight / 2.5,
                            ),
                          ],
                        );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: screenHeight / 1.15),
              child: HomePageTabbarDesign(),
            ),
          ],
        ),
      ),
    );
  }
}


// import 'package:weather_app/export.dart';
//
// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   WeatherData _weatherData = WeatherData();
//
//   @override
//   void initState() {
//     super.initState();
//     _getCurrentLocationWeather();
//   }
//
//   Future<void> _getCurrentLocationWeather() async {
//     WeatherService weatherService = WeatherService();
//     try {
//       Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
//       if (position.latitude != null && position.longitude != null) {
//         var latLong = ("${position.latitude}" ',' "${position.longitude}");
//         await weatherService.getLocationData(latLong);
//         setState(() {
//           _weatherData = weatherService.weatherData;
//         });
//       }
//     } catch (e) {
//       print("Hata: $e");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Weather App',
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Weather App'),
//         ),
//         body: Center(
//           child: _weatherData == null
//               ? CircularProgressIndicator()
//               : Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text('Location: ${_weatherData.location?.name}'),
//                     SizedBox(height: 10),
//                     Text('Temperature: ${_weatherData.current?.temp_c}°C'),
//                     SizedBox(height: 10),
//                     Text('Condition: ${_weatherData.current?.condition.text}'),
//                   ],
//                 ),
//         ),
//       ),
//     );
//   }
// }

//  Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text('Location: ${model.weatherData.location?.name}'),
//                             SizedBox(height: 10),
//                             Text('Temperature: ${model.weatherData.current?.temp_c}°C'),
//                             SizedBox(height: 10),
//                             Text('Condition: ${model.weatherData.current?.condition.text}'),
//                             SizedBox(height: 10),
//                             SizedBox(width: 75, height: 75, child: SvgPicture.asset(wing)),
//                           ],
//                         );
