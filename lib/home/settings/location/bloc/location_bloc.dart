import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/home/settings/location/bloc/location_events.dart';
import 'package:untitled2/home/settings/location/bloc/location_states.dart';

class LocationBloc extends Bloc<LocationEvents,LocationStates>{
  LocationBloc():super(LocationStates()){
  on<TriggerZoneEvent>(_triggerZoneEvents);
  on<TriggerDivisionEvent>(_triggerDivisionEvents);
  on<TriggerSectionEvent>(_triggerSectionEvents);
  on<TriggerDivisionListEvent>(_triggerDivisionListEvent);
  on<TriggerSectionListEvent>(_triggerSectionListEvent);

  on<TriggerZoneListEvent>(_triggerZoneListEvent);
  }

  void _triggerZoneEvents(TriggerZoneEvent event , Emitter<LocationStates> emit){
   emit(state.copyWith(zone: event.zone));
  }

  void _triggerDivisionEvents(TriggerDivisionEvent event , Emitter<LocationStates> emit){
   emit(state.copyWith(division: event.division));
  }

  void _triggerSectionEvents(TriggerSectionEvent event , Emitter<LocationStates> emit){
   emit(state.copyWith(section: event.section));
  }

  void _triggerZoneListEvent(TriggerZoneListEvent event,Emitter<LocationStates> emit){
    emit(state.copyWith(zones: event.zones));
  }

  void _triggerSectionListEvent(TriggerSectionListEvent event,Emitter<LocationStates> emit){
    emit(state.copyWith(sections: event.section));
  }

  void _triggerDivisionListEvent(TriggerDivisionListEvent event,Emitter<LocationStates> emit){
    emit(state.copyWith(divisions: event.division));
  }
}