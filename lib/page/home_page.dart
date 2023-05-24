import 'package:provider/provider.dart';

import 'package:weather_app/export.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    TextTheme darkTextTheme = WeatherAppTheme.darkTextTheme;
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            backGroundPage,
            fit: BoxFit.cover,
            width: screenWidth,
            height: screenHeight,
          ),
          Center(
            child: Consumer<WeatherDataFromAPI>(
              builder: (context, model, child) {
                // ignore: unnecessary_null_comparison
                return model.weatherData == null
                    ? const CircularProgressIndicator()
                    : _centerDesign(model, darkTextTheme, screenWidth, screenHeight);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: screenHeight / 1.15),
            child: HomePageTabbarDesign(),
          ),
        ],
      ),
    );
  }

  Column _centerDesign(WeatherDataFromAPI model, TextTheme darkTextTheme, double screenWidth, double screenHeight) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "${model.weatherData?.location?.name}",
          style: darkTextTheme.bodyLarge,
        ),
        Text(
          "${model.weatherData?.current?.temp_c}°",
          style: darkTextTheme.bodyLarge,
        ),
        Text(
          "${model.weatherData?.current?.condition?.text}",
          style: darkTextTheme.bodyMedium?.copyWith(
            color: Colors.white60,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Nem : ${model.weatherData?.current?.humidity}%",
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
  }
}
