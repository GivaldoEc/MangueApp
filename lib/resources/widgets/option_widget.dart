import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

Widget optWidget(
  onTap,
  String containerString,
) {
  return InkWell(
    onTap: onTap,
    child: Container(
      height: 50,
      color: Colors.green,
      child: Center(
        child: Text(containerString),
      ),
    ),
  );
}

List<Widget> bleList(List<BluetoothDevice> deviceList, ontap) {
  return deviceList.map((x) => optWidget(ontap, x.toString())).toList();
}
