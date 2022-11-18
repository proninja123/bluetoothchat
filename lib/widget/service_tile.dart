import 'package:bluetoothchat/widget/characterstics_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class ServiceTile extends StatelessWidget {
  ServiceTile(
      {Key? key, /*required this.id*/ required this.bluetoothCharacteristic})
      : super(key: key);

 // String id;
  List<BluetoothCharacteristic> bluetoothCharacteristic;

  @override
  Widget build(BuildContext context) {
    if (bluetoothCharacteristic.isNotEmpty) {
      return ExpansionTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Services",
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
            Text(id)
          ],
        ),
        children: bluetoothCharacteristic.map((e) {
          return StreamBuilder(builder: (context, snapshot) {
            return CharacteristicTile(
                uuid: e.uuid.toString(),
                remoteId: e.serviceUuid.toString(),
                serviceUuid: e.serviceUuid.toString(),
                secondaryServiceUuid: e.secondaryServiceUuid.toString(),
                descriptors: e.descriptors,
                properties: e.properties);
          });
        }).toList(),
      );
    } else {
      return ListTile(
        title: const Text(
          "Services",
          style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(id),
      );
    }
  }
}
