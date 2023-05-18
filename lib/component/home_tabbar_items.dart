import 'package:provider/provider.dart';
import 'package:weather_app/export.dart';
import 'package:intl/intl.dart';

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
          IconButton(
            onPressed: () {},
            color: Colors.white,
            iconSize: 26,
            icon: Icon(Icons.gps_fixed),
          ),
          IconButton(
            onPressed: () {
              _showBottomSheet(context);
            },
            iconSize: 48,
            color: Colors.white,
            icon: Icon(Icons.add),
          ),
          IconButton(
            onPressed: () {},
            color: Colors.white,
            iconSize: 26,
            icon: Icon(Icons.list),
          ),
        ],
      ),
    );
  }
}

_showBottomSheet(BuildContext context) {
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
          return Consumer<WeatherDataFromAPI>(
            builder: (context, value, child) {
              Current? currentWeatherData = value.weatherData.current;
              Location? locationWeatherData = value.weatherData.location;
              ForecastDay? forecastWeatherData = value.weatherData.forecast?.forecastday?[0];
              int? usEpaIndex = currentWeatherData?.air_quality?.usEpaIndex;

              return value.loading
                  ? Text('HATA')
                  : tabController(scrollController, value, forecastWeatherData, currentWeatherData, usEpaIndex);
            },
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
              _tabBarWeatherDataWeeks(),
            ],
          ),
        ),
        airQuality(usEpaIndex),
      ],
    ),
  );
}

ListView _hourlyForecastItems(WeatherDataFromAPI value, ForecastDay? forecastWeatherData, Current? currentWeatherData) {
  return ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: forecastWeatherData?.hour?.length,
    itemBuilder: (BuildContext context, int index) {
      var forecastHours = forecastWeatherData?.hour?[index];
      var time = DateTime.parse(forecastHours!.time.toString());
      var timeString = DateFormat('hh a').format(time);
      double? usEpaIndex = currentWeatherData?.air_quality?.usEpaIndex?.toDouble();

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

Container _hourlyForecastItemsDesign(String timeString, Hour forecastHours) {
  return Container(
    width: 80,
    height: 160,
    padding: const EdgeInsets.only(top: 12),
    margin: const EdgeInsets.all(8),
    decoration: const BoxDecoration(
      color: Colors.blue,
      borderRadius: BorderRadius.all(Radius.circular(36)),
      boxShadow: [
        BoxShadow(
          color: Colors.white,
          spreadRadius: 2,
          blurRadius: 5,
          offset: Offset(0, 3),
        ),
      ],
    ),
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

Expanded airQuality(int? usEpaIndex) {
  return Expanded(
    child: ListView(
      shrinkWrap: true,
      children: [
        Container(
          height: 175,
          decoration: const BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.all(Radius.circular(36)),
            boxShadow: [
              BoxShadow(
                color: Colors.white,
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(3, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('AIR QUALITY', style: WeatherAppTheme.darkTextTheme.bodyMedium),
                _buildAirQualityText(usEpaIndex!),
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
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 40,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.red,
                ),
                margin: EdgeInsets.all(18),
                width: 56,
                height: 125,
              ),
            ),
            Expanded(
              flex: 40,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.red,
                ),
                margin: EdgeInsets.all(18),
                width: 56,
                height: 125,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildAirQualityText(int usEpaIndex) {
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
          Container(
            width: 56,
            height: 125,
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.all(
                Radius.circular(36),
              ),
            ),
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
