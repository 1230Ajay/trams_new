import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/home/bloc/home_events.dart';
import 'package:untitled2/home/bloc/home_states.dart';

class HomeBloc extends Bloc<HomeEvents,HomeStates>{

  HomeBloc():super(HomeStates()){
   on<isStartedEvents>(_isStarted);
   on<DataEvent>(_dataEvent);

  }

  void _isStarted(isStartedEvents event ,Emitter<HomeStates> emit){
    emit(state.copyWith(isStarted: event.isStarted));
  }

  void _dataEvent(DataEvent event , Emitter<HomeStates> emit){
    emit(state.copyWith(data: event.data));
  }

}