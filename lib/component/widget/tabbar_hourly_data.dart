import 'package:intl/intl.dart';

import '../../export.dart';

// ignore: must_be_immutable
class HourlyForecastData extends StatelessWidget {
  WeatherDataFromAPI? value;
  ForecastDay? forecastWeatherData;
  Current? currentWeatherData;
  HourlyForecastData({
    Key? key,
    this.value,
    this.forecastWeatherData,
    this.currentWeatherData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
