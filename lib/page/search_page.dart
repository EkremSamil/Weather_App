import 'package:provider/provider.dart';
import 'package:weather_app/data/search_weather_data.dart';

import '../export.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xF31C0F48),
        title: Text('Weather'),
        elevation: 0,
        bottomOpacity: 0,
        titleTextStyle: WeatherAppTheme.darkTextTheme.bodyMedium?.copyWith(),
      ),
      body: ChangeNotifierProvider(
        create: (_) => WeatherSearchData(),
        child: Consumer<WeatherSearchData>(
          builder: (context, weatherSearchData, _) {
            List<String> searchHistory = weatherSearchData.searchHistory;

            return Container(
              color: Color(0xF31C0F48),
              height: screenHeight,
              width: screenWidth,
              child: Column(
                children: [
                  _searchBar(weatherSearchData),
                  SizedBox(height: screenHeight * 0.05),
                  _searchItems(searchHistory, weatherSearchData, screenWidth, screenHeight),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Expanded _searchItems(
    List<String> searchHistory,
    WeatherSearchData weatherSearchData,
    double screenWidth,
    double screenHeight,
  ) {
    return Expanded(
      child: ListView.builder(
        itemCount: searchHistory.length,
        itemBuilder: (context, index) {
          WeatherData? weatherData = weatherSearchData.searchResults.reversed.toList()[index];
          print(weatherData);
          Current? currentWeatherData = weatherData.current;
          ForecastDay? forecastWeatherData = weatherData.forecast?.forecastday?[0];

          return Container(
            padding: EdgeInsets.all(12),
            width: screenWidth / 1.5,
            height: screenHeight / 3.5,
            margin: EdgeInsets.symmetric(vertical: 8.0),
            child: Container(
              width: screenWidth / 1.2,
              height: screenHeight / 3,
              decoration: const BoxDecoration(
                color: Color(0xF3194C90),
                borderRadius: BorderRadius.only(
                  topRight: Radius.elliptical(250, 150),
                  topLeft: Radius.circular(50),
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${currentWeatherData?.temp_c}°",
                          style: WeatherAppTheme.darkTextTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 48,
                          ),
                        ),
                        SizedBox(height: screenHeight / 50),
                        Text(
                          "${weatherData.location?.name}, ${weatherData.location?.country}",
                          style: WeatherAppTheme.darkTextTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: screenWidth / 3,
                    height: screenHeight / 4.5,
                    child: Image.network(
                      'https:${forecastWeatherData?.day?.condition?.icon}',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Container _searchBar(WeatherSearchData weatherSearchData) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: TextField(
        onSubmitted: (value) {
          String enteredText = _searchController.text;
          print(enteredText);

          weatherSearchData.searchWeatherData(enteredText);
        },
        controller: _searchController,
        style: WeatherAppTheme.darkTextTheme.bodyMedium?.copyWith(),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.deepPurpleAccent,
          counterStyle: WeatherAppTheme.darkTextTheme.bodyMedium?.copyWith(),
          hintText: 'Search for a city',
          hintStyle: WeatherAppTheme.darkTextTheme.bodySmall?.copyWith(),
          suffixIcon: IconButton(
            icon: Icon(Icons.clear),
            onPressed: () => _searchController.clear(),
          ),
          prefixIcon: IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              String enteredText = _searchController.text;
              print(enteredText);

              weatherSearchData.searchWeatherData(enteredText);
            },
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(style: BorderStyle.solid, color: Colors.white),
            borderRadius: BorderRadius.circular(20.0),
          ),
          suffixIconColor: Colors.white,
          prefixIconColor: Colors.white,
        ),
      ),
    );
  }
}
