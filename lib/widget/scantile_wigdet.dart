import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_blue_plus/gen/flutterblueplus.pb.dart';

class ScanTileWidget extends StatelessWidget {
  ScanTileWidget(
      {Key? key, required this.name, required this.id, this.onTap })
      : super(key: key);

  String name;
  String id;
  final VoidCallback? onTap;
  //BluetoothDeviceType device;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                id,
                style: TextStyle(fontSize: 14, color: Colors.blue),
              )
            ],
          ),
          const Spacer(),
          ElevatedButton(onPressed: onTap ?? () {}, child: const Text('Connect'))
        ],
      ),
    );
  }
}
