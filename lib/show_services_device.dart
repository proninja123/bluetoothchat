import 'package:bluetoothchat/widget/characterstics_tile.dart';
import 'package:bluetoothchat/widget/service_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class ShowServicesDevice extends StatefulWidget {
  ShowServicesDevice({Key? key, required this.device}) : super(key: key);

  final BluetoothDevice device;

  @override
  State<ShowServicesDevice> createState() => _ShowServicesDeviceState();
}

class _ShowServicesDeviceState extends State<ShowServicesDevice> {
  Future<List<BluetoothService>>? services;

  @override
  void initState() {
    searchForServices();
    super.initState();
  }

  searchForServices() async {
    services = widget.device.discoverServices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("Services"),
        actions: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StreamBuilder(
                  stream: widget.device.state,
                  builder: (context, snapshot) {
                    if (snapshot.data == BluetoothDeviceState.connected) {
                      return Container(
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10)),
                        padding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Text("Connected"),
                      );
                    } else {
                      return Container(
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10)),
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Text('Disconnected'),
                      );
                    }
                  })
            ],
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StreamBuilder(
                stream: widget.device.state,
                builder: (context, snapshot) {
                  return Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            snapshot.data == BluetoothDeviceState.connected
                                ? "Device is Connected"
                                : "Device is Disconnected",
                            style: const TextStyle(
                                fontSize: 19, fontWeight: FontWeight.bold),
                          ),
                          Text(widget.device.id.id),
                        ],
                      ),
                      const Spacer(),
                      IconButton(
                          onPressed: () {}, icon: const Icon(Icons.refresh))
                    ],
                  );
                }),
            const Divider(
              thickness: 3,
            ),
            Expanded(
              child: StreamBuilder<List<BluetoothService>>(
                stream: widget.device.services,
                builder: (context, snapshot) {
                  if (widget.device.services != null) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          for (int i = 0; i < snapshot.data!.length; i++)
                            ServiceTile(
                                bluetoothCharacteristic:
                                snapshot.data![i].characteristics,)
                        ],
                      ),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
