
import '../../common/entities/location.dart';

abstract class HomeEvents{
 const HomeEvents();
}

class isStartedEvents extends HomeEvents{
  final bool? isStarted;
  const isStartedEvents({this.isStarted});
}

class DataEvent extends HomeEvents{
  final String data;
  DataEvent({required this.data});
}


