import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:insulin/bluetooth/connenction_screen.dart';

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
      appBar: AppBar(centerTitle: true, title: Text('bluetooth app')),
      body: Column(
        children: [
          SwitchListTile(
              value: _bluetoothState.isEnabled,
              title: Text('Enable bluetooth'),
              onChanged: (value) {
                if (value) {
                  FlutterBluetoothSerial.instance.requestEnable();
                } else {
                  FlutterBluetoothSerial.instance.requestDisable();
                }
                setState(() {});
              }),
          TextButton(
              onPressed: () {
                FlutterBluetoothSerial.instance.openSettings();
              },
              child: Text('Open settings')),
          ...List.generate(
              _devices.length,
              (index) => InkWell(
                onTap: (){Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>ConnectionScreen(device: _devices[index])));},
                child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Text(_devices[index].name.toString())),
              ))
        ],
      ),
    );
  }
}
