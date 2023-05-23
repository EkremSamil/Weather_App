import 'package:intl/intl.dart';

import '../../export.dart';

// ignore: must_be_immutable
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
        var forecastDay = value?.weatherData.forecast?.forecastday?[index];
        var date = forecastDay?.date;

        var dayOfWeek = DateFormat('EEEE').format(DateTime.parse(date.toString()));
        var convertedDay = '';

        switch (dayOfWeek) {
          case 'Monday':
            convertedDay = 'MON';
            break;
          case 'Tuesday':
            convertedDay = 'TUE';
            break;
          case 'Wednesday':
            convertedDay = 'WEBS';
            break;
          case 'Thursday':
            convertedDay = 'THU';
            break;
          case 'Friday':
            convertedDay = 'FRI';
            break;
          case 'Saturday':
            convertedDay = 'SAT';
            break;
          case 'Sunday':
            convertedDay = 'SUN';
            break;
          default:
            convertedDay = '';
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomContainer(
              height: 160,
              width: 80,
              margin: const EdgeInsets.all(8),
              padding: EdgeInsets.only(top: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('$convertedDay', style: WeatherAppTheme.darkTextTheme.bodySmall),
                  Text('${forecastDay?.day?.avgtemp_c}°', style: WeatherAppTheme.darkTextTheme.bodySmall),
                  Image.network('https:${forecastDay?.day?.condition?.icon}'),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
