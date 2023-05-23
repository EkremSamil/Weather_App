import 'package:provider/provider.dart';

import '../export.dart';

class HomePageTabbarDesign extends StatelessWidget {
  const HomePageTabbarDesign({super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight / 2,
      width: screenWidth,
      color: Color(0xF31C0F48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const GPSFixedIconButton(),
          AddIconButton(
            onPressed: () {
              _showBottomSheet(context);
            },
          ),
          ListIconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchPage(),
                  ));
            },
          ),
        ],
      ),
    );
  }
}

void _showBottomSheet(BuildContext context) {
  WeatherDataFromAPI weatherDataFromAPI = Provider.of<WeatherDataFromAPI>(context, listen: false);

  showModalBottomSheet(
    backgroundColor: Color(0xDC1C137C),
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return DraggableScrollableSheet(
        initialChildSize: 0.4,
        maxChildSize: 1.0,
        expand: false,
        builder: (BuildContext context, ScrollController scrollController) {
          WeatherData weatherData = weatherDataFromAPI.weatherData;
          Current? currentWeatherData = weatherData.current;
          ForecastDay? forecastWeatherData = weatherData.forecast?.forecastday?[0];
          int? usEpaIndex = currentWeatherData?.air_quality?.usEpaIndex;

          return weatherDataFromAPI.loading
              ? CircularProgressIndicator()
              : tabController(
                  scrollController,
                  weatherDataFromAPI,
                  forecastWeatherData,
                  currentWeatherData,
                  usEpaIndex,
                );
        },
      );
    },
  );
}

DefaultTabController tabController(ScrollController scrollController, WeatherDataFromAPI value,
    ForecastDay? forecastWeatherData, Current? currentWeatherData, int? usEpaIndex) {
  return DefaultTabController(
    length: 2,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _tabBarTitle(scrollController),
        Container(
          padding: EdgeInsets.only(top: 16),
          width: double.infinity,
          height: 200,
          child: TabBarView(
            children: [
              HourlyForecastData(
                value: value,
                forecastWeatherData: forecastWeatherData,
                currentWeatherData: currentWeatherData,
              ),
              WeeklyForecastData(
                value: value,
                forecastWeatherData: forecastWeatherData,
                currentWeatherData: currentWeatherData,
              ),
            ],
          ),
        ),
        AirQualityData(
          forecastWeatherData: forecastWeatherData,
          currentWeatherData: currentWeatherData,
          usEpaIndex: usEpaIndex,
        ),
      ],
    ),
  );
}

TabBar _tabBarTitle(ScrollController scrollController) {
  return TabBar(
    tabs: [
      Tab(
        child: ListView(
          controller: scrollController,
          padding: const EdgeInsets.only(top: 14),
          children: [
            Text('Hourly Forecast', style: WeatherAppTheme.darkTextTheme.bodyMedium),
          ],
        ),
      ),
      Tab(
        child: ListView(
          padding: const EdgeInsets.only(top: 14),
          controller: scrollController,
          children: [
            Text('Weekly Forecast', style: WeatherAppTheme.darkTextTheme.bodyMedium),
          ],
        ),
      ),
    ],
  );
}
