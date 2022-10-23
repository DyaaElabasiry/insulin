import 'package:flutter/material.dart';
import 'package:insulin/bluetooth/bluetooth_serial_page.dart';
import 'package:insulin/linear_liquid_progress.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import 'chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'I Band',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BluetoothSerialWidget(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.maxFinite,
                height: 350,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30)),
                    gradient: LinearGradient(
                        colors: [
                          Color.fromRGBO(130, 120, 248, 1),
                          Color.fromRGBO(154, 145, 255, 1)
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 12),
                      child: IconButton(
                          icon: Icon(Icons.menu),
                          iconSize: 30,
                          color: Colors.white,
                          onPressed: () {}),
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(128, 118, 255, 1),
                          shape: BoxShape.circle),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        'Dyaa Elabasiry',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                            fontWeight: FontWeight.w700),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 150,
              ),
              Padding(
                padding: EdgeInsets.all(25),
                child: Text(
                  'Glucose track chart',
                  style: TextStyle(fontWeight: FontWeight.w500,
                      fontSize: 22,
                      letterSpacing: 0,
                      color: Colors.black54),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: LineChartSample2(),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.fromLTRB(17, 225, 17, 0),
            height: 250,
            width: double.maxFinite,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)]),
            child: Expanded(
              child: Row(
                children: [
                  Expanded(
                      child: SizedBox(
                        width: double.maxFinite,
                        child: SleekCircularSlider(
                          innerWidget: (value) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Glucose level',
                                  style: TextStyle(color: Colors.black54),
                                ),
                                Text(
                                  '${value.toInt()}',
                                  style: TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  'mg/dL',
                                  style: TextStyle(color: Colors.black54),
                                ),
                              ],
                            );
                          },
                          appearance: CircularSliderAppearance(
                              animationEnabled: true,
                              animDurationMultiplier: 1.1,
                              spinnerMode: false,
                              customColors: CustomSliderColors(
                                  hideShadow: true,
                                  dotColor: Colors.transparent,
                                  progressBarColors: [
                                    Color.fromRGBO(250, 92, 103, 1),
                                    Color.fromRGBO(104, 92, 250, 1),
                                  ]),
                              size: 200,
                              customWidths:
                              CustomSliderWidths(progressBarWidth: 15)),
                          min: 90,
                          max: 250,
                          initialValue: 100,
                        )
                      )),
                  MyLiquidProgress(percent: 70,),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
