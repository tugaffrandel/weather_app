import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:weather_app_bloc/bloc/weather_bloc.dart';

class HomePage extends StatelessWidget {
  final Position position;
  const HomePage({super.key, required this.position});

  Widget getWeatherCondition(int code) {
    switch (code) {
      case > 199 && < 233:
        return Image.asset(
            'thunderbolt_storm_heavy rain_thunderstorm_weather_rain_cloud.png');
      case > 199 && < 322:
        return Image.asset('assets/weather_cloud_drizzle_rain.png');
      case > 499 && < 532:
        return Image.asset('assets/weather_rain_heavy rain_cloud.png');
      case > 599 && < 623:
        return Image.asset('assets/cloud_cold_weather_snow.png');
      case > 700 && < 782:
        return Image.asset('assets/weather_cloud.png');
      case == 800:
        return Image.asset('assets/cloudy_sunny_weather_cloud_sun.png');
      case > 800 && < 805:
        return Image.asset('assets/weather_cloud.png');
      default:
        return Image.asset('assets/cloud_weather_sun_sunny.png');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              context.read<WeatherBloc>().add(FetchWeather(position: position));
            },
            icon: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.refresh,
                size: 40,
                color: Colors.white,
              ),
            ),
          )
        ],
        backgroundColor: Colors.transparent,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(40, 1.2 * kToolbarHeight, 40, 20),
        child: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            if (state is WeatherSuccess) {
              return SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    Align(
                      alignment: const AlignmentDirectional(4, -0.3),
                      child: Container(
                        height: 300,
                        width: 300,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue.shade400,
                        ),
                      ),
                    ),
                    Align(
                      alignment: const AlignmentDirectional(-4, -0.3),
                      child: Container(
                        height: 300,
                        width: 300,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue.shade400,
                        ),
                      ),
                    ),
                    Align(
                      alignment: const AlignmentDirectional(0, -1.2),
                      child: Container(
                        height: 300,
                        width: 300,
                        decoration: const BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Color(0xFFFFab40),
                        ),
                      ),
                    ),
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "📍 ${state.weather.areaName}",
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w300),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const Text(
                            'Good Morning',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                          getWeatherCondition(
                              state.weather.weatherConditionCode!),
                          Center(
                            child: Text(
                              '${(state.weather.temperature?.celsius?.round())} °C',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 55,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              state.weather.weatherMain
                                  .toString()
                                  .toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              DateFormat('EEEE dd ·')
                                  .add_jm()
                                  .format(state.weather.date!),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/sun.png',
                                    scale: 4,
                                    fit: BoxFit.cover,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Sunrise',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                        DateFormat()
                                            .add_jm()
                                            .format(state.weather.sunrise!),
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/moon.png',
                                    scale: 5,
                                    fit: BoxFit.cover,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Sunset',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                        DateFormat()
                                            .add_jm()
                                            .format(state.weather.sunset!),
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: Divider(
                              color: Colors.grey,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/hot.png',
                                    scale: 5,
                                    fit: BoxFit.cover,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Temp Max',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                        '${state.weather.tempMax!.celsius!.round()} °C',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/cold.png',
                                    scale: 5,
                                    fit: BoxFit.cover,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Temp Min',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                        '${state.weather.tempMin!.celsius!.round()} °C',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
