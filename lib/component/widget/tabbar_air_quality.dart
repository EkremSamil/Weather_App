import '../../export.dart';

// ignore: must_be_immutable
class AirQualityData extends StatelessWidget {
  int? usEpaIndex;
  Current? currentWeatherData;
  ForecastDay? forecastWeatherData;
  AirQualityData({
    Key? key,
    this.usEpaIndex,
    this.currentWeatherData,
    this.forecastWeatherData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
