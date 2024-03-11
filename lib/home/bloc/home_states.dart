
import 'package:untitled2/common/entities/location.dart';

class HomeStates{
  final bool? isStarted;
  final String? data;




  const HomeStates({this.isStarted=false,this.data=""});

  HomeStates copyWith({bool? isStarted,String? data,LocationEntity? location,String? zone,String? section,String? division}){
    print("${zone}  ${division} ${section}");
    return HomeStates(isStarted: isStarted??this.isStarted,data: data??this.data);
  }
}