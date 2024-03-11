import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/common/entities/database.dart';
import 'package:untitled2/global.dart';
import 'package:untitled2/home/settings/location/bloc/location_bloc.dart';
import 'package:untitled2/home/settings/location/bloc/location_events.dart';
import 'package:untitled2/home/settings/location/widgets/location_widgets.dart';

import '../../../common/values/widgets.dart';

class LocationController{
  late BuildContext context;
  LocationController({required this.context});

  void init()async{
    String locationString = await Global.storageService.getLocationData();
    Map<String,dynamic> data = jsonDecode(locationString);

    context.read<LocationBloc>().add(TriggerZoneEvent(data["zone"]));
    context.read<LocationBloc>().add(TriggerDivisionEvent(data["division"]));
    context.read<LocationBloc>().add(TriggerSectionEvent(data["section"]));

    List<ZoneEntity> zones = await Global.dataBaseService.getAllZones();
    context.read<LocationBloc>().add(TriggerZoneListEvent(zones: zones));

    List<DivisionEntity> divsions = await Global.dataBaseService.getDivisionsForZone(context.read<LocationBloc>().state.zone??"");
    context.read<LocationBloc>().add(TriggerDivisionListEvent(division: divsions));

    List<SectionEntity> sections = await Global.dataBaseService.getSectionsForDivision(context.read<LocationBloc>().state.section??"");
    context.read<LocationBloc>().add(TriggerSectionListEvent(section: sections));
  }

  void addZone({required String zone}){
    ZoneEntity zoneEntity = ZoneEntity(name: zone);
    Global.dataBaseService.insertZone(zoneEntity);
  }

  void addDivsion({required String division}){
    DivisionEntity divisionEntity = DivisionEntity(name:division, zoneId:0);
    Global.dataBaseService.insertDivision(division: divisionEntity, zoneName:context.read<LocationBloc>().state.zone!);
  }

  void addSection({required String section}){
    SectionEntity sectionEntity = SectionEntity(name:section,divisionId: 0);
    Global.dataBaseService.insertSection(section: sectionEntity, divisionName:context.read<LocationBloc>().state.zone!);
  }


  void showInputPopup(BuildContext context,
      {required void Function(String value) onSave,required String name}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ReusablePopup(
          onSave:onSave,
          name: name,
        );
      },
    );
  }

}