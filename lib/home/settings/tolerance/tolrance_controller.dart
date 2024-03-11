import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/common/entities/tolerance.dart';
import 'package:untitled2/common/values/constants.dart';
import 'package:untitled2/global.dart';
import 'package:untitled2/home/settings/tolerance/bloc/tolerance_bloc.dart';

import 'bloc/tolerabce_events.dart';

class ToleranceController{
  late BuildContext context;

  ToleranceController({required this.context});

  void init()async{
   String tolerance = await Global.storageService.getTolerance();
   Map<String,dynamic> data =  jsonDecode(tolerance);
   if(context.mounted){

     context.read<ToleranceBloc>().add(GuageMaxEvent(data["gaugeMax"]??0));
     context.read<ToleranceBloc>().add(LevelMaxEvent(data["levelMax"]??0));
     context.read<ToleranceBloc>().add(ElevationMaxEvent(data["elevationMax"]??0));
     context.read<ToleranceBloc>().add(TempMaxEvent(data["temperatureMax"]??0));
     context.read<ToleranceBloc>().add(TwistMaxEvent(data["twistMax"]??0));

     context.read<ToleranceBloc>().add(GuageMinEvent(data["gaugeMin"]??0));
     context.read<ToleranceBloc>().add(LevelMinEvent(data["levelMin"]??0));
     context.read<ToleranceBloc>().add(ElevationMinEvent(data["elevationMin"]??0));
     context.read<ToleranceBloc>().add(TempMinEvent(data["temperatureMin"]??0));
     context.read<ToleranceBloc>().add(TwistMinEvent(data["twistMin"]??0));

   }

  }


  double decrease({required double value}){
    value = value-1;
    return value;
  }

  double increase({required double value}){
    value = value+1;
    return value;
  }

}