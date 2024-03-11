import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../home/bloc/home_bloc.dart';
import '../../home/home.dart';
import '../../home/settings/calibration/bloc/calibration_bloc.dart';
import '../../home/settings/calibration/calibration.dart';
import '../../home/settings/location/bloc/location_bloc.dart';
import '../../home/settings/location/location.dart';
import '../../home/settings/tolerance/bloc/tolerance_bloc.dart';
import '../../home/settings/tolerance/tolerance.dart';
import 'names.dart';

class AppPages{
  static List<PageEntity> Routes(){
    return [
      PageEntity(route: AppRoutes.HOME_PAGE, page: MyHomePage(),bloc: BlocProvider(create: (_)=>HomeBloc(),)),
      PageEntity(route: AppRoutes.TOLERANCE, page: TolerancePage(),bloc: BlocProvider(create: (_)=>ToleranceBloc(),)),
      PageEntity(route: AppRoutes.CALIBRATION, page: CalibrationPage(),bloc: BlocProvider(create: (_)=>CalibrationBloc(),)),
      PageEntity(route: AppRoutes.LOCATION, page: LocationPage(),bloc: BlocProvider(create: (_)=>LocationBloc(),)),
    ];
  }


  static List<BlocProvider> allBlocProviders(BuildContext context){
    List<BlocProvider> blocProviders = <BlocProvider>[];
    for(var bloc in Routes()){
      if(bloc.bloc!=null){
        blocProviders.add(bloc.bloc);
      }
    }

    return blocProviders;
  }

  static MaterialPageRoute GenrRatePageRoute(RouteSettings settings){
    if(settings!=null){
      var result = Routes().where((element) => element.route==settings.name);
      if(result.isNotEmpty){
        return MaterialPageRoute(builder: (_)=>result.first.page,settings: settings);
      }
    }
    return MaterialPageRoute(builder: (_)=>const MyHomePage(),settings: settings);
  }

}




class PageEntity{
   String route;
   Widget page;
   dynamic bloc;
  PageEntity({required this.route,required this.page,this.bloc});
}