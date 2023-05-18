import 'package:json_annotation/json_annotation.dart';

part 'weather_model.g.dart';

@JsonSerializable()
class WeatherData {
  final Location? location;
  final Current? current;
  final Forecast? forecast;

  WeatherData({this.location, this.current, this.forecast});

  factory WeatherData.fromJson(Map<String, dynamic> json) => _$WeatherDataFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherDataToJson(this);
}

@JsonSerializable()
class Location {
  final String? name;
  final String? region;
  final String? country;
  final double? lat;
  final double? lon;
  final String? tz_id;
  final int? localtime_epoch;
  final String? localtime;

  Location({
    this.name,
    this.region,
    this.country,
    this.lat,
    this.lon,
    this.tz_id,
    this.localtime_epoch,
    this.localtime,
  });

  factory Location.fromJson(Map<String, dynamic> json) => _$LocationFromJson(json);
  Map<String?, dynamic> toJson() => _$LocationToJson(this);
}

@JsonSerializable()
class Current {
  final int? last_updated_epoch;
  final String? last_updated;
  final double? temp_c;
  final double? temp_f;
  final int? is_day;
  final Condition? condition;
  final double? wind_mph;
  final double? wind_kph;
  final int? wind_degree;
  final String? wind_dir;
  final double? pressure_mb;
  final double? pressure_in;
  final double? precip_mm;
  final double? precip_in;
  final int? humidity;
  final int? cloud;
  final double? feelslike_c;
  final double? feelslike_f;
  final double? vis_km;
  final double? vis_miles;
  final double? uv;
  final double? gust_mph;
  final double? gust_kph;

  Current({
    this.last_updated_epoch,
    this.last_updated,
    this.temp_c,
    this.temp_f,
    this.is_day,
    this.condition,
    this.wind_mph,
    this.wind_kph,
    this.wind_degree,
    this.wind_dir,
    this.pressure_mb,
    this.pressure_in,
    this.precip_mm,
    this.precip_in,
    this.humidity,
    this.cloud,
    this.feelslike_c,
    this.feelslike_f,
    this.vis_km,
    this.vis_miles,
    this.uv,
    this.gust_mph,
    this.gust_kph,
  });

  factory Current.fromJson(Map<String, dynamic> json) => _$CurrentFromJson(json);
  Map<String?, dynamic> toJson() => _$CurrentToJson(this);
}

@JsonSerializable()
class Condition {
  final String? text;
  final String? icon;
  final int? code;

  Condition({
    this.text,
    this.icon,
    this.code,
  });

  factory Condition.fromJson(Map<String, dynamic> json) => _$ConditionFromJson(json);
  Map<String?, dynamic> toJson() => _$ConditionToJson(this);
}

@JsonSerializable()
class Forecast {
  final List<ForecastDay>? forecastday;

  Forecast({
    this.forecastday,
  });

  factory Forecast.fromJson(Map<String, dynamic> json) => _$ForecastFromJson(json);
  Map<String?, dynamic> toJson() => _$ForecastToJson(this);
}

@JsonSerializable()
class ForecastDay {
  final String? date;
  final int? date_epoch;
  final Day? day;
  final Astro? astro;
  final List<Hour>? hour;

  ForecastDay({
    this.date,
    this.date_epoch,
    this.day,
    this.astro,
    this.hour,
  });

  factory ForecastDay.fromJson(Map<String, dynamic> json) => _$ForecastDayFromJson(json);
  Map<String?, dynamic> toJson() => _$ForecastDayToJson(this);
}

@JsonSerializable()
class Day {
  final double? maxtemp_c;
  final double? maxtemp_f;
  final double? mintemp_c;
  final double? mintemp_f;
  final double? avgtemp_c;
  final double? avgtemp_f;
  final double? maxwind_mph;
  final double? maxwind_kph;
  final double? totalprecip_mm;
  final double? totalprecip_in;
  final double? totalsnow_cm;
  final double? avgvis_km;
  final double? avgvis_miles;
  final double? avghumidity;
  final int? daily_will_it_rain;
  final int? daily_chance_of_rain;
  final int? daily_will_it_snow;
  final int? daily_chance_of_snow;
  final Condition? condition;
  final double? uv;

  Day({
    this.maxtemp_c,
    this.maxtemp_f,
    this.mintemp_c,
    this.mintemp_f,
    this.avgtemp_c,
    this.avgtemp_f,
    this.maxwind_mph,
    this.maxwind_kph,
    this.totalprecip_mm,
    this.totalprecip_in,
    this.totalsnow_cm,
    this.avgvis_km,
    this.avgvis_miles,
    this.avghumidity,
    this.daily_will_it_rain,
    this.daily_chance_of_rain,
    this.daily_will_it_snow,
    this.daily_chance_of_snow,
    this.condition,
    this.uv,
  });

  factory Day.fromJson(Map<String, dynamic> json) => _$DayFromJson(json);
  Map<String?, dynamic> toJson() => _$DayToJson(this);
}

@JsonSerializable()
class Astro {
  final String? sunrise;
  final String? sunset;
  final String? moonrise;
  final String? moonset;
  final String? moon_phase;
  final String? moon_illumination;
  final int? is_moon_up;
  final int? is_sun_up;

  Astro({
    this.sunrise,
    this.sunset,
    this.moonrise,
    this.moonset,
    this.moon_phase,
    this.moon_illumination,
    this.is_moon_up,
    this.is_sun_up,
  });

  factory Astro.fromJson(Map<String, dynamic> json) => _$AstroFromJson(json);
  Map<String?, dynamic> toJson() => _$AstroToJson(this);
}

@JsonSerializable()
class Hour {
  final int? time_epoch;
  final String? time;
  final double? temp_c;
  final double? temp_f;
  final int? is_day;
  final Condition? condition;
  final double? wind_mph;
  final double? wind_kph;
  final int? wind_degree;
  final String? wind_dir;
  final double? pressure_mb;
  final double? pressure_in;
  final double? precip_mm;
  final double? precip_in;
  final int? humidity;
  final int? cloud;
  final double? feelslike_c;
  final double? feelslike_f;
  final double? windchill_c;
  final double? windchill_f;
  final double? heatindex_c;
  final double? heatindex_f;
  final double? dewpoint_c;
  final double? dewpoint_f;
  final int? will_it_rain;
  final int? chance_of_rain;
  final int? will_it_snow;
  final int? chance_of_snow;
  final double? vis_km;
  final double? vis_miles;
  final double? gust_mph;
  final double? gust_kph;
  final double? uv;

  Hour({
    this.time_epoch,
    this.time,
    this.temp_c,
    this.temp_f,
    this.is_day,
    this.condition,
    this.wind_mph,
    this.wind_kph,
    this.wind_degree,
    this.wind_dir,
    this.pressure_mb,
    this.pressure_in,
    this.precip_mm,
    this.precip_in,
    this.humidity,
    this.cloud,
    this.feelslike_c,
    this.feelslike_f,
    this.windchill_c,
    this.windchill_f,
    this.heatindex_c,
    this.heatindex_f,
    this.dewpoint_c,
    this.dewpoint_f,
    this.will_it_rain,
    this.chance_of_rain,
    this.will_it_snow,
    this.chance_of_snow,
    this.vis_km,
    this.vis_miles,
    this.gust_mph,
    this.gust_kph,
    this.uv,
  });

  factory Hour.fromJson(Map<String, dynamic> json) => _$HourFromJson(json);
  Map<String?, dynamic> toJson() => _$HourToJson(this);
}


// import 'package:json_annotation/json_annotation.dart';
// 
// part 'weather_model.g.dart';
// 
// @JsonSerializable()
// class WeatherData {
//   Location? location;
//   Current? current;
//   WeatherData({
//     this.location,
//     this.current,
//   });
// 
//   factory WeatherData.fromJson(Map<String?, dynamic> json) => _$WeatherDataFromJson(json);
// 
//   Map<String?, dynamic> toJson() => _$WeatherDataToJson(this);
// }
// 
// @JsonSerializable()
// class Location {
//   final String? name;
//   final String? region;
//   final String? country;
//   final double? lat;
//   final double? lon;
//   final String? tz_id;
//   final int? localtime_epoch;
//   final String? localtime;
// 
//   Location({
//      this.name,
//      this.region,
//      this.country,
//      this.lat,
//      this.lon,
//      this.tz_id,
//      this.localtime_epoch,
//      this.localtime,
//   });
// 
//   factory Location.fromJson(Map<String?, dynamic> json) => _$LocationFromJson(json);
// 
//   Map<String?, dynamic> toJson() => _$LocationToJson(this);
// }
// 
// @JsonSerializable()
// class Current {
//   final int? last_updated_epoch;
//   final String? last_updated;
//   final double? temp_c;
//   final double? temp_f;
//   final int? is_day;
//   final Condition? condition;
//   final double? wind_mph;
//   final double? wind_kph;
//   final int? wind_degree;
//   final String? wind_dir;
//   final double? pressure_mb;
//   final double? pressure_in;
//   final double? precip_mm;
//   final double? precip_in;
//   final int? humidity;
//   final int? cloud;
//   final double? feelslike_c;
//   final double? feelslike_f;
//   final double? vis_km;
//   final double? vis_miles;
//   final double? uv;
//   final double? gust_mph;
//   final double? gust_kph;
// 
//   Current({
//      this.last_updated_epoch,
//      this.last_updated,
//      this.temp_c,
//      this.temp_f,
//      this.is_day,
//      this.condition,
//      this.wind_mph,
//      this.wind_kph,
//      this.wind_degree,
//      this.wind_dir,
//      this.pressure_mb,
//      this.pressure_in,
//      this.precip_mm,
//      this.precip_in,
//      this.humidity,
//      this.cloud,
//      this.feelslike_c,
//      this.feelslike_f,
//      this.vis_km,
//      this.vis_miles,
//      this.uv,
//      this.gust_mph,
//      this.gust_kph,
//   });
// 
//   factory Current.fromJson(Map<String?, dynamic> json) => _$CurrentFromJson(json);
// 
//   Map<String?, dynamic> toJson() => _$CurrentToJson(this);
// }
// 
// @JsonSerializable()
// class Condition? {
//   final String? text;
//   final String? icon;
//   final int? code;
// 
//   Condition?({
//      this.text,
//      this.icon,
//      this.code,
//   });
// 
//   factory Condition?.fromJson(Map<String?, dynamic> json) => _$ConditionFromJson(json);
// 
//   Map<String?, dynamic> toJson() => _$ConditionToJson(this);
// }
