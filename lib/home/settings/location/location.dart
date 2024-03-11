import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/common/colors/colors.dart';
import 'package:untitled2/common/entities/database.dart';
import 'package:untitled2/common/values/constants.dart';
import 'package:untitled2/home/bloc/home_bloc.dart';
import 'package:untitled2/home/bloc/home_events.dart';
import 'package:untitled2/home/settings/location/bloc/location_bloc.dart';
import 'package:untitled2/home/settings/location/bloc/location_events.dart';
import 'package:untitled2/home/settings/location/bloc/location_states.dart';
import 'package:untitled2/home/settings/location/location_controller.dart';
import 'package:untitled2/home/settings/location/widgets/location_widgets.dart';
import 'package:untitled2/home/settings/widgets/setting_widgets.dart';

import '../../../common/controller/global_controller.dart';
import '../../../common/entities/location.dart';
import '../../../global.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  String zoneHint = "Select Zone";
  String divisionHint = "Select Division";
  String sectionHint = "Select Section";

  late LocationController _locationController;

  @override
  void didChangeDependencies() {
    _locationController = LocationController(context: context);
    _locationController.init();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationBloc, LocationStates>(builder: (context, state) {
      return SettingPageScreens(
          title: "Location",
          child: Container(
            width: 624,
            height: 360,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      LocationTile(
                          dataList: state.zones,
                          hintText: state.zone == "" ? zoneHint : state.zone!,
                          name: "Zone",
                          add: () {
                            setState(() {
                              showInputPopup(context, name: "Zone",
                                  onSave: (value) async {
                                ZoneEntity zone = ZoneEntity(name: value);
                                await Global.dataBaseService.insertZone(zone);
                                List<ZoneEntity> zones =
                                    await Global.dataBaseService.getAllZones();
                                context
                                    .read<LocationBloc>()
                                    .add(TriggerZoneListEvent(zones: zones));
                              });
                            });
                          },
                          onSelect: (value) async {
                            context
                                .read<LocationBloc>()
                                .add(TriggerZoneEvent(value));
                            context
                                .read<LocationBloc>()
                                .add(TriggerDivisionEvent(""));
                            context
                                .read<LocationBloc>()
                                .add(TriggerSectionEvent(""));

                            List<DivisionEntity> divsions = await Global
                                .dataBaseService
                                .getDivisionsForZone(value);
                            context.read<LocationBloc>().add(
                                TriggerDivisionListEvent(division: divsions));
                          },
                          onDelete: () {}),
                      LocationTile(
                          dataList: state.divisions,
                          hintText: state.division == ""
                              ? divisionHint
                              : state.division!,
                          name: "Division",
                          add: () {
                            setState(() {
                              showInputPopup(context, name: "Divsion",
                                  onSave: (value) async {
                                DivisionEntity division =
                                    DivisionEntity(name: value);
                                await Global.dataBaseService.insertDivision(
                                    division: division, zoneName: state.zone!);
                                List<DivisionEntity> divsions = await Global
                                    .dataBaseService
                                    .getDivisionsForZone(state.zone!);
                                context.read<LocationBloc>().add(
                                    TriggerDivisionListEvent(
                                        division: divsions));
                              });
                            });
                          },
                          onSelect: (value) async {
                            context
                                .read<LocationBloc>()
                                .add(TriggerDivisionEvent(value));
                            context
                                .read<LocationBloc>()
                                .add(TriggerSectionEvent(""));

                            List<SectionEntity> sections = await Global
                                .dataBaseService
                                .getSectionsForDivision(value);
                            context.read<LocationBloc>().add(
                                TriggerSectionListEvent(section: sections));
                          },
                          onDelete: () {}),
                      LocationTile(
                          dataList: state.sections,
                          hintText: state.section == ""
                              ? sectionHint
                              : state.section!,
                          name: "Section",
                          add: () {
                            setState(() {
                              showInputPopup(context, name: "Section",
                                  onSave: (value) async {
                                SectionEntity section =
                                    SectionEntity(name: value);
                                await Global.dataBaseService.insertSection(
                                    section: section,
                                    divisionName: state.division!);

                                List<SectionEntity> sections = await Global
                                    .dataBaseService
                                    .getSectionsForDivision(state.division!);
                                context.read<LocationBloc>().add(
                                    TriggerSectionListEvent(section: sections));
                              });
                            });
                          },
                          onSelect: (value) {
                            context
                                .read<LocationBloc>()
                                .add(TriggerSectionEvent(value));
                          },
                          onDelete: () {
                            showInputPopup(context, name: "Section",
                                onSave: (value) {
                              print(value);
                            });
                          }),
                    ],
                  ),
                ),
                SizedBox(
                  height: 28,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      child: primaryButton(
                          btnName: "Save",
                          onPress: () {
                            if (state.zone != "" &&
                                state.division != "" &&
                                state.section != "") {
                              LocationEntity _locationEntity = LocationEntity();
                              _locationEntity.zone = state.zone;
                              _locationEntity.division = state.division;
                              _locationEntity.section = state.section;
                              Global.storageService.setString(
                                  key: AppConstants.lOCATION,
                                  value: jsonEncode(_locationEntity.toJson()));

                              DialogBarForInfoAndAlert(context, title:"Data Saved", message: "Location saved");

                            }
                          }),
                    ),
                  ],
                )
              ],
            ),
          ));
    });
  }
}
