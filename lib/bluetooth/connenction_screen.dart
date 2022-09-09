import 'dart:convert';
import 'dart:typed_data';
import 'package:convert/convert.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:insulin/bluetooth/bluetooth_serial_page.dart';
import 'package:insulin/bluetooth/example.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '../chart.dart';
import '../linear_liquid_progress.dart';

class ConnectionScreen extends StatefulWidget {
  final BluetoothDevice device;

  const ConnectionScreen({super.key, required this.device});

  @override
  State<ConnectionScreen> createState() => _ConnectionScreenState();
}

class _ConnectionScreenState extends State<ConnectionScreen> {
  late BluetoothConnection connection;
  bool isConnecting = true;
  double message = 100;
  List<Widget> messages =[];
  String _messageBuffer = '';
  @override
  void initState() {
    super.initState();
    _getBTConnection();
  }
  @override
  void dispose(){
    super.dispose();
    connection.dispose();
  }

  _getBTConnection()  {
    BluetoothConnection.toAddress(widget.device.address).then((_connection) {
      print('device connected');
      connection =_connection ;
      isConnecting = false;
      setState(() {});
      connection.input!.listen(_onDataReceived).onDone(() {

      });
    });
  }

  void _onDataReceived(Uint8List data) {

    // Allocate buffer for parsed data
    int backspacesCounter = 0;
    data.forEach((byte) {
      if (byte == 8 || byte == 127) {
        backspacesCounter++;
      }
    });
    Uint8List buffer = Uint8List(data.length - backspacesCounter);
    int bufferIndex = buffer.length;

    // Apply backspace control character
    backspacesCounter = 0;
    for (int i = data.length - 1; i >= 0; i--) {
      if (data[i] == 8 || data[i] == 127) {
        backspacesCounter++;
      } else {
        if (backspacesCounter > 0) {
          backspacesCounter--;
        } else {
          buffer[--bufferIndex] = data[i];
        }
      }
    }

    // Create message if there is new line character
    String dataString = String.fromCharCodes(buffer);
    int index = buffer.indexOf(13);
    if (~index != 0) {
      print('message added 1');
      setState(() {
        messages.add(
          Text(
            backspacesCounter > 0
                ? _messageBuffer.substring(
                0, _messageBuffer.length - backspacesCounter)
                : _messageBuffer + dataString.substring(0, index),
          ),
        );
        _messageBuffer = dataString.substring(index);
      });
    } else {
      print('message added 2');
      _messageBuffer = (backspacesCounter > 0
          ? _messageBuffer.substring(
          0, _messageBuffer.length - backspacesCounter)
          : _messageBuffer + dataString);

    }
    if(_messageBuffer.endsWith('\n')){
      _messageBuffer.replaceAll('\n', '');
      message = double.parse(_messageBuffer[0]+_messageBuffer[1]+_messageBuffer[2]);
      _messageBuffer='';
      print('message received');
      print('${message}');
      setState(() {});
    }
  }

  _sendMessage(String text) async {
    text = text.trim();

    connection.output.add(Uint8List.fromList(utf8.encode(text )));
    await connection.output.allSent;
    print('message sent');
  }

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
                  style: TextStyle(fontWeight: FontWeight.w500,fontSize: 22,letterSpacing: 0,color: Colors.black54),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: LineChartSample2(),
              )
            ],
          ),
          GestureDetector(
            onTap: (){
              _sendMessage('1');
            },
            child: Container(
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
                                        fontSize: 40, fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    'mg/dL',
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                ],
                              );
                            },
                            appearance: CircularSliderAppearance(
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
                            initialValue: message,
                          ),
                        )),
                    MyLiquidProgress(percent: message<210 ? 70:60),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

