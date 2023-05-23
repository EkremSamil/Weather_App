import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:weather_app/component/buttons/home_page_add_icon_button.dart';
import 'package:weather_app/component/buttons/home_page_gps_icon_button.dart';
import 'package:weather_app/component/buttons/home_page_list_icon_button.dart';
import 'package:weather_app/component/tabbar_custom_container.dart';
import 'package:weather_app/export.dart';

class HomePageTabbarDesign extends StatelessWidget {
  const HomePageTabbarDesign({super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight / 2,
      width: screenWidth,
      color: Color(0x945C50E0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const GPSFixedIconButton(),
          AddIconButton(onPressed: () {
            _showBottomSheet(context);
          }),
          const ListIconButton(),
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
        TabBarTitle(scrollController),
        Container(
          padding: EdgeInsets.only(top: 16),
          width: double.infinity,
          height: 200,
          child: TabBarView(
            children: [
              _hourlyForecastItems(value, forecastWeatherData, currentWeatherData),
              WeeklyForecastData(
                value: value,
                forecastWeatherData: forecastWeatherData,
                currentWeatherData: currentWeatherData,
              ),
            ],
          ),
        ),
        airQualityCardWidget(usEpaIndex, currentWeatherData, forecastWeatherData),
      ],
    ),
  );
}

class WeeklyForecastData extends StatelessWidget {
  WeatherDataFromAPI? value;
  ForecastDay? forecastWeatherData;
  Current? currentWeatherData;

  WeeklyForecastData({
    Key? key,
    this.value,
    this.forecastWeatherData,
    this.currentWeatherData,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: value?.weatherData.forecast?.forecastday?.length,
      itemBuilder: (BuildContext context, int index) {
        var forecastHours = forecastWeatherData?.hour?[index];
        var time = DateTime.parse(forecastHours!.time.toString());
        var timeString = DateFormat('hh a').format(time);

        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomContainer(
              height: 160,
              margin: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('${timeString}', style: WeatherAppTheme.darkTextTheme.bodySmall),
                  Text(' ${forecastHours.temp_c}°C', style: WeatherAppTheme.darkTextTheme.bodySmall),
                  Text('${forecastHours.humidity}% Hmdty', style: WeatherAppTheme.darkTextTheme.bodySmall),
                  Image.network('https:${forecastHours.condition?.icon}')
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

ListView _hourlyForecastItems(WeatherDataFromAPI value, ForecastDay? forecastWeatherData, Current? currentWeatherData) {
  return ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: forecastWeatherData?.hour?.length,
    itemBuilder: (BuildContext context, int index) {
      var forecastHours = forecastWeatherData?.hour?[index];
      var time = DateTime.parse(forecastHours!.time.toString());
      var timeString = DateFormat('hh a').format(time);

      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _hourlyForecastItemsDesign(timeString, forecastHours),
        ],
      );
    },
  );
}

CustomContainer _hourlyForecastItemsDesign(String timeString, Hour forecastHours) {
  return CustomContainer(
    height: 160,
    margin: const EdgeInsets.all(8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text('${timeString}', style: WeatherAppTheme.darkTextTheme.bodySmall),
        Text(' ${forecastHours.temp_c}°C', style: WeatherAppTheme.darkTextTheme.bodySmall),
        Text('${forecastHours.humidity}% Hmdty', style: WeatherAppTheme.darkTextTheme.bodySmall),
        Image.network('https:${forecastHours.condition?.icon}')
      ],
    ),
  );
}

Expanded airQualityCardWidget(int? usEpaIndex, Current? currentWeatherData, ForecastDay? forecastWeatherData) {
  return Expanded(
    child: ListView(
      padding: const EdgeInsets.all(24),
      shrinkWrap: true,
      children: [
        _airQualityCurrentData(usEpaIndex),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _uvIndexCurrentAirData(currentWeatherData),
            _sunsetCurrentAirData(forecastWeatherData),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _visibilityCurrentAirData(currentWeatherData),
            _feelsLikeCurrentAirData(currentWeatherData),
          ],
        ),
      ],
    ),
  );
}

CustomContainer _airQualityCurrentData(int? usEpaIndex) {
  return CustomContainer(
    height: 175,
    margin: EdgeInsets.zero,
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('AIR QUALITY', style: WeatherAppTheme.darkTextTheme.bodyMedium),
          _buildairQualityCardWidgetText(usEpaIndex!),
          SizedBox(height: 15),
          Slider(
            thumbColor: Colors.red,
            inactiveColor: Colors.white,
            activeColor: Colors.black,
            value: usEpaIndex.toDouble(),
            min: 0.0,
            max: 6.0,
            divisions: 6,
            label: usEpaIndex.toString(),
            onChanged: (double value) {
              usEpaIndex = value.toInt();
            },
          ),
          const SizedBox(height: 15),
        ],
      ),
    ),
  );
}

Expanded _uvIndexCurrentAirData(Current? currentWeatherData) {
  return Expanded(
    child: CustomContainer(
      height: 150,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('UV Index', style: WeatherAppTheme.darkTextTheme.bodySmall),
            SizedBox(height: 5),
            Text('${currentWeatherData?.uv}', style: WeatherAppTheme.darkTextTheme.bodyMedium),
            SizedBox(height: 5),
            _buildUvIndexText(currentWeatherData!.uv!.toInt()),
          ],
        ),
      ),
    ),
  );
}

Expanded _sunsetCurrentAirData(ForecastDay? forecastWeatherData) {
  return Expanded(
    child: CustomContainer(
      height: 150,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.sunny),
            Text('${forecastWeatherData?.astro?.sunrise}', style: WeatherAppTheme.darkTextTheme.bodySmall),
            SizedBox(height: 15),
            Icon(Icons.shield_moon),
            Text('${forecastWeatherData?.astro?.sunset}', style: WeatherAppTheme.darkTextTheme.bodySmall),
          ],
        ),
      ),
    ),
  );
}

Expanded _visibilityCurrentAirData(Current? currentWeatherData) {
  return Expanded(
    child: CustomContainer(
      height: 150,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.visibility),
                SizedBox(width: 10),
                Text('Visibility', style: WeatherAppTheme.darkTextTheme.bodySmall),
              ],
            ),
            SizedBox(height: 5),
            Text('${currentWeatherData?.vis_km}', style: WeatherAppTheme.darkTextTheme.bodyMedium),
          ],
        ),
      ),
    ),
  );
}

Expanded _feelsLikeCurrentAirData(Current? currentWeatherData) {
  return Expanded(
    child: CustomContainer(
      height: 150,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.thermostat),
                Text('FEELS LIKE', style: WeatherAppTheme.darkTextTheme.bodySmall),
              ],
            ),
            Text('${currentWeatherData?.feelslike_c}°', style: WeatherAppTheme.darkTextTheme.bodyMedium),
          ],
        ),
      ),
    ),
  );
}

Widget _buildUvIndexText(int currentWeatheruv) {
  String description;
  Color color;

  if (currentWeatheruv <= 2) {
    description = 'Good';
    color = Colors.green;
  } else if (currentWeatheruv > 2 && currentWeatheruv <= 5) {
    description = 'Moderate';
    color = Colors.yellowAccent;
  } else if (currentWeatheruv > 5 && currentWeatheruv < 8) {
    description = 'High';
    color = Colors.red;
  } else if (currentWeatheruv > 7 && currentWeatheruv < 11) {
    description = 'Very High';
    color = Colors.brown;
  } else if (currentWeatheruv >= 11) {
    description = 'Extreme';
    color = Colors.black;
  } else {
    description = 'Unknown';
    color = Colors.grey;
  }

  return Text(
    description,
    style: WeatherAppTheme.darkTextTheme.bodySmall?.copyWith(color: color),
  );
}

Widget _buildairQualityCardWidgetText(int usEpaIndex) {
  String description = '';
  Color? color;

  switch (usEpaIndex) {
    case 1:
      description = 'Good';
      color = Colors.green;
      break;
    case 2:
      description = 'Moderate';
      color = Colors.yellowAccent;
      break;
    case 3:
      description = 'Unhealthy';
      color = Colors.redAccent;
      break;
    case 4:
      description = 'Unhealthy';
      color = Colors.red;
      break;
    case 5:
      description = 'Very Unhealthy';
      color = Colors.brown;
      break;
    case 6:
      description = 'Hazardous';
      color = Colors.black;
      break;
  }

  return Text(
    description,
    style: WeatherAppTheme.darkTextTheme.bodySmall?.copyWith(color: color),
  );
}

ListView _tabBarWeatherDataWeeks() {
  return ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: 20,
    itemBuilder: (BuildContext context, int index) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomContainer(
            height: 125,
            margin: const EdgeInsets.all(4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('data'),
                Text('data'),
                Text('data'),
              ],
            ),
          ),
        ],
      );
    },
  );
}

TabBar TabBarTitle(ScrollController scrollController) {
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
