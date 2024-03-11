import 'dart:async';
import 'dart:convert';

import 'dart:math';
import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../common/entities/data_entity.dart';
import '../global.dart';

class sysInfo {
  DateTime? dateTime;
  int? battery;
  sysInfo({this.dateTime, this.battery});
}

class HomeController {
  BuildContext context;
  HomeController(this.context);

  Stream<sysInfo> dateTime() async* {
    while (true) {
      await Future.delayed(Duration(seconds: 1));
      yield sysInfo(
          dateTime: await DateTime.now(),
          battery: await Battery().batteryLevel);
    }
  }

   Stream<Map<String,dynamic>> getLocationCordinatesLive() async* {
    while(true){
      bool serviceEnabled;
      LocationPermission permission;

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        print("please enable service to get location");
      }

      permission = await Geolocator.checkPermission();
      if(permission==await LocationPermission.denied){
        permission = await Geolocator.requestPermission();
        if(permission==LocationPermission.denied){
          print("sorry we cant continue because you have denied location permission");
        }
      }

      Position currentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
      String long = ((currentPosition.longitude).toStringAsFixed(6)).toString();
      String lat = ((currentPosition.latitude).toStringAsFixed(6)).toString();
      Future.delayed(Duration(seconds:1));
      yield {"lat":lat,"long":long};
    }
  }

  Stream<Map<String, dynamic>> getLocation() async* {
    while (true) {
      var location = await Global.storageService.getLocationData();
      if (location != "") {
        Map<String, dynamic> locationJson = jsonDecode(location);
        await Future.delayed(Duration(seconds: 1));
        yield locationJson;
      } else {
        await Future.delayed(Duration(seconds: 1));
        yield {
          "zone": "set zone",
          "division": "set division",
          "section": "set section"
        };
      }
    }
  }

// Import this for utf8.decode

  Stream<DataEntity> readData() async* {
    while (true) {
      List<int> gauge = [-2, -1, 0, 1, 2];
      List<int> level = [-2, -1, 0, 1, 2];
      List<int> gradient = [-2, -1, 0, 1, 2];

      List<int> twist = [1, 2, 3, 4];
      List<int> temp = [5, 6, 7, 8, 9];
      List<int> speed = [22, 23, 24, 25];
      Random random = Random();

      int gaugeIndex = random.nextInt(gauge.length);
      int levelIndex = random.nextInt(level.length);
      int gradientIndex = random.nextInt(gradient.length);

      int twistIndex = random.nextInt(twist.length);
      int tempIndex = random.nextInt(temp.length);
      int speedIndex = random.nextInt(speed.length);

      // Yield the DataEntity after a 2-second delay
      await Future.delayed(Duration(seconds: 1));
      yield DataEntity(
        gauge: gauge[gaugeIndex],
        level: level[levelIndex],
        gradient: gradient[gradientIndex],
        twist: twist[twistIndex],
        temp: temp[tempIndex],
        speed: speed[speedIndex],
      );
    }
  }
}
