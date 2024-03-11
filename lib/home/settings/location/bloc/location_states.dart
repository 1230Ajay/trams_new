import '../../../../common/entities/database.dart';

class LocationStates{
  final String? zone;
  final String? division;
  final String? section;
  final List<ZoneEntity> zones;
  final List<DivisionEntity> divisions;
  final List<SectionEntity> sections;
  const LocationStates({this.zone="",this.section="",this.division="",this.zones=const <ZoneEntity>[],this.divisions = const <DivisionEntity>[],this.sections=const <SectionEntity>[]});
  LocationStates copyWith({String? zone,String? section,String? division,List<ZoneEntity>? zones,List<DivisionEntity>? divisions,List<SectionEntity>? sections}){
    return LocationStates(zone: zone??this.zone,division: division??this.division,section: section??this.section,zones: zones??this.zones,sections: sections??this.sections,divisions: divisions??this.divisions);
  }
}