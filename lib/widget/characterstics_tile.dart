import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/gen/flutterblueplus.pb.dart';

class CharacteristicTile extends StatelessWidget {
  CharacteristicTile(
      {Key? key,
      required this.uuid,
      required this.remoteId,
      required this.serviceUuid,
      required this.secondaryServiceUuid,
      required this.descriptors,
      required this.properties
      })
      : super(key: key);

  String uuid;
  String remoteId;
  String serviceUuid;
  String secondaryServiceUuid;
  List<BluetoothDescriptor> descriptors;
  CharacteristicProperties properties;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
