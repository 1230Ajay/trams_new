import '../../../../common/entities/database.dart';

abstract class LocationEvents{
  LocationEvents();
}

class TriggerZoneEvent extends LocationEvents{
  final String zone;
  TriggerZoneEvent(this.zone);
}

class TriggerDivisionEvent extends LocationEvents{
  final String division;
  TriggerDivisionEvent(this.division);
}

class TriggerSectionEvent extends LocationEvents{
  final String section;
  TriggerSectionEvent(this.section);
}

class TriggerZoneListEvent extends LocationEvents{
  List<ZoneEntity> zones;
  TriggerZoneListEvent({required this.zones});
}

class TriggerDivisionListEvent extends LocationEvents{
  List<DivisionEntity> division;
  TriggerDivisionListEvent({required this.division});
}

class TriggerSectionListEvent extends LocationEvents{
  List<SectionEntity> section;
  TriggerSectionListEvent({required this.section});
}