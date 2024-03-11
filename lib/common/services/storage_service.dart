
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled2/common/values/constants.dart';

class StorageService{
  late final SharedPreferences _sharedPreferences;

  Future<StorageService> init()async{
    _sharedPreferences = await SharedPreferences.getInstance();
    return this;
  }

  Future<bool> setBool({required String key,required bool value}) async {
    return await _sharedPreferences.setBool(key, value);
  }

  Future <bool> setString({required String key,required String value}) async {
    return await _sharedPreferences.setString(key, value);
  }

  Future<bool> remove({required String key}) async {
    return await _sharedPreferences.remove(key);
  }

  Future<String> getTolerance() async {
    return await _sharedPreferences.getString(AppConstants.TOLERANCE)??'';
  }

  Future<String> getCalibration() async {
    return await _sharedPreferences.getString(AppConstants.CALIBRATION)??'';
  }

  Future<bool> getIsDataBaseExist()async{
    return await _sharedPreferences.getBool(AppConstants.IS_DATA_BASE_EXISTS)??false;
  }

  Future<String> getLocationData()async{
    return await _sharedPreferences.getString(AppConstants.lOCATION)??"";
  }

}