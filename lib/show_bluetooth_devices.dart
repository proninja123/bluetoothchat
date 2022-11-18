import 'package:bluetoothchat/show_services_device.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import 'widget/scantile_wigdet.dart';

class ShowBluetoothDevices extends StatefulWidget {
  const ShowBluetoothDevices({Key? key}) : super(key: key);

  @override
  State<ShowBluetoothDevices> createState() => _ShowBluetoothDevicesState();
}

class _ShowBluetoothDevicesState extends State<ShowBluetoothDevices> {
  FlutterBluePlus flutterBlue = FlutterBluePlus.instance;

  @override
  void initState() {
    flutterBlue.startScan(timeout: const Duration(seconds: 4));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Bluetooth Devices"),
      ),
      body: RefreshIndicator(
        onRefresh: () =>
            flutterBlue.startScan(timeout: const Duration(seconds: 4)),
        child: StreamBuilder(
          stream: flutterBlue.scanResults,
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (int i = 0; i < snapshot.data!.length; i++)
                      ScanTileWidget(
                        name: snapshot.data![i].device.name,
                        id: snapshot.data![i].device.id.id,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context)  {
                                    snapshot.data![i].device.connect();
                                    return ShowServicesDevice(
                                      device: snapshot.data![i].device,
                                    );
                                  }));
                        },
                      )
                  ],
                ),
              );
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
