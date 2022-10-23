import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:insulin/bluetooth/connenction_screen.dart';
import 'package:switcher_button/switcher_button.dart';

class BluetoothSerialWidget extends StatefulWidget {
  @override
  State<BluetoothSerialWidget> createState() => _BluetoothSerialWidgetState();
}

class _BluetoothSerialWidgetState extends State<BluetoothSerialWidget> {
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;
  List<BluetoothDevice> _devices = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getBTState();
    _stateChangeListener();
    _listBondedDevices();
  }

  _getBTState() {
    FlutterBluetoothSerial.instance.state.then((state) {
      _bluetoothState = state;
      if (_bluetoothState.isEnabled) {
        _listBondedDevices();
      }
      setState(() {});
    });
  }

  _stateChangeListener() {
    FlutterBluetoothSerial.instance.onStateChanged().listen((state) {
      _bluetoothState = state;
      if (_bluetoothState.isEnabled) {
        _listBondedDevices();
      } else {
        _devices.clear();
      }
      setState(() {});
    });
  }

  _listBondedDevices() {
    FlutterBluetoothSerial.instance.getBondedDevices().then((devices) {
      _devices = devices;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [

                SizedBox(
                  height: 105,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      'Bluetooth',
                      style: TextStyle(
                          color: Colors.black87.withOpacity(0.7),
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                    Expanded(child: SizedBox()),
                    CupertinoSwitch(
                        value: _bluetoothState.isEnabled,
                        onChanged: (value) {
                          if (value) {
                            FlutterBluetoothSerial.instance.requestEnable();
                          } else {
                            FlutterBluetoothSerial.instance.requestDisable();
                          }
                          setState(() {});
                        }),
                    SizedBox(
                      width: 30,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                // TextButton(
                //     onPressed: () {
                //       FlutterBluetoothSerial.instance.openSettings();
                //     },
                //     child: Text('Open settings')),
                ...List.generate(
                    _devices.length,
                    (index) => InkWell(
                          onTap: () {
                            Navigator.of(context).pushReplacement(MaterialPageRoute(
                                builder: (context) =>
                                    ConnectionScreen(device: _devices[index])));
                          },
                          child: Container(
                            padding: EdgeInsets.only(top: 20,bottom: 20,left: 30,right: 30),
                            margin: EdgeInsets.all(10),
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(_devices[index].name.toString(),style: TextStyle(fontWeight: FontWeight.w500,fontSize: 17),),
                                    SizedBox(height: 10,),
                                    Text('Saved')
                                  ],
                                ),
                                Expanded(child: SizedBox()),
                                Container(
                                  padding: EdgeInsets.all(5),
                                  child: Icon(Icons.arrow_forward_ios),
                                  decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.1), shape: BoxShape.circle),
                                )
                              ],
                            ),
                          ),
                        ))
              ],
            ),
          ),
          Container(
            height: 90,
            width: double.maxFinite,
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 33),
            decoration: BoxDecoration(
                color: Color.fromRGBO(154, 145, 255, 1),
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15))),
            child: Text(
              'Connect to device',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
