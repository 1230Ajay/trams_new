import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../common/values/constants.dart';
import '../../../global.dart';
import 'bloc/calibration_bloc.dart';
import 'bloc/calibration_events.dart';

class CalibrationController{
  late BuildContext context;
  CalibrationController({required this.context});

  void init()async{
    String calibration = await Global.storageService.getTolerance();
    Map<String,dynamic> data =  jsonDecode(calibration);
    if(context.mounted){
      context.read<CalibrationBloc>().add(TriggerGaugeEvent(data["gauge"]??0));
      context.read<CalibrationBloc>().add(TriggerLevelEvent(data["level"]??0));
      context.read<CalibrationBloc>().add(TriggerAlignmentEvent(data["alignment"]??0));
      context.read<CalibrationBloc>().add(TriggerTempEvent(data["temp"]??0));
      context.read<CalibrationBloc>().add(TriggerTwistEvent(data["twist"]??0));
      context.read<CalibrationBloc>().add(TriggerGradientEvent(data["gradient"]??0));
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