import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/model/model.dart';

class WeatherScreen extends StatefulWidget {
  WeatherScreen({this.parseWeatherData, this.parseAirPollution});
  final dynamic parseWeatherData;
  final dynamic parseAirPollution;
  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Model model = Model();
  String? cityName;
  int? temp;
  Widget? icon;
  String? des;
  Widget? pollution;
  Widget? quality;
  double? air;
  double? air2;
  var date = DateTime.now();

  @override

  void initState() {
    // TODO: implement initState
    super.initState();
    updateData(widget.parseWeatherData, widget.parseAirPollution);
  }

  void updateData(dynamic weatherData, dynamic airData){
    double temp2 = weatherData['main']['temp'].toDouble();
    temp = temp2.toInt();
    cityName = weatherData['name'];
    var condition = weatherData['weather'][0]['id'];
    var grade = airData['list'][0]['main']['aqi'];
    var index = airData['list'][0]['main']['aqi'];
    des = weatherData['weather'][0]['description'];
    icon = model.getWeatherIcon(condition);
    pollution = model.getAirIcon(grade);
    quality = model.airIndex(index);
    air = airData['list'][0]['components']['pm10'].toDouble();
    air2 = airData['list'][0]['components']['pm2_5'].toDouble();
    print(temp);
    print(cityName);
  }

  String? getSystemTime(){
    var now = DateTime.now();
    return DateFormat('h:mm a').format(now);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        //title: Text(''),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.near_me),
          onPressed: () {},
          iconSize: 30,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.location_searching,),
            iconSize: 30,
          )
        ],
      ),
      body: Container(
        child: Stack(
          children: [
            Image.asset('image/background.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 150,
                            ),
                            Text('$cityName',
                              style: GoogleFonts.lato(
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Row(
                              children: [
                                TimerBuilder.periodic(
                                    (Duration(minutes: 1)),
                                    builder: (context){
                                      print('${getSystemTime()}');
                                      return Text(
                                          '${getSystemTime()}',
                                        style: GoogleFonts.lato(
                                          fontSize: 16,
                                          color: Colors.white
                                        ),
                                      );
                                    },
                                ),
                                Text(
                                  DateFormat(' - EEEE, ').format(date),
                                  style: GoogleFonts.lato(
                                      fontSize: 16,
                                      color: Colors.white
                                  )
                                ),
                                Text(
                                  DateFormat('d mm, yyy').format(date),
                                    style: GoogleFonts.lato(
                                        fontSize: 16,
                                        color: Colors.white
                                    )
                                ),
                              ],
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('$temp\u2103',
                              style: GoogleFonts.lato(
                                fontSize: 85,
                                fontWeight: FontWeight.w300,
                                color: Colors.white,
                              ),
                            ),
                            Row(
                              children: [
                                icon!,
                                SizedBox(
                                  width: 10
                                ),
                                Text('$des',
                                  style: GoogleFonts.lato(
                                      fontSize: 16,
                                      color: Colors.white
                                  )
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Divider(
                        height: 15,
                        thickness: 2,
                        color: Colors.white30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text('AQI(대기질지수)',
                                  style: GoogleFonts.lato(
                                      fontSize: 14,
                                      color: Colors.white
                                  )
                              ),
                              SizedBox(height: 10,),
                              pollution!,
                              SizedBox(height: 10,),
                              quality!,
                            ],
                          ),
                          Column(
                            children: [
                              Text('미세먼지',
                                  style: GoogleFonts.lato(
                                      fontSize: 14,
                                      color: Colors.white
                                  )
                              ),
                              SizedBox(height: 10,),
                              Text('$air2',
                                  style: GoogleFonts.lato(
                                      fontSize: 24,
                                      color: Colors.white
                                  )
                              ),
                              SizedBox(height: 10,),
                              Text('㎍/㎥',
                                  style: GoogleFonts.lato(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  )
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text('초미세먼지',
                                  style: GoogleFonts.lato(
                                      fontSize: 14,
                                      color: Colors.white
                                  )
                              ),
                              SizedBox(height: 10,),
                              Text('$air',
                                  style: GoogleFonts.lato(
                                      fontSize: 24,
                                      color: Colors.white
                                  )
                              ),
                              SizedBox(height: 10,),
                              Text('㎍/㎥ ',
                                  style: GoogleFonts.lato(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  )
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}
