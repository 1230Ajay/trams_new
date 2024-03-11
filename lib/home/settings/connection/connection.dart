import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled2/common/controller/global_controller.dart';
import 'package:untitled2/home/settings/connection/widgets/conection_widget.dart';


import '../../../common/values/constants.dart';
import '../../../global.dart';
import '../widgets/setting_widgets.dart';

class ConnectionPage extends StatefulWidget {
  const ConnectionPage({super.key});

  @override
  State<ConnectionPage> createState() => _ConnectionPageState();
}

class _ConnectionPageState extends State<ConnectionPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SettingPageScreens(
          title: "Connection",
          child: Container(
            width: 624,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                ConnectionTile(dataList: ["COM1","COM2","COM2"], hintText:"Select Port", name: "COM Port", onSelect: (value){

                }),
                SizedBox(height: 24,),
                ConnectionTile(dataList: ["9600","115200","230400"], hintText:"Select Baud rade", name: "Baud Rate", onSelect: (value){

                }),

                SizedBox(height: 48,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      child: primaryButton(btnName:"Save",onPress:(){
                        Global.storageService.setString(key:AppConstants.BAUDRATE , value: 'value');
                        Global.storageService.setString(key:AppConstants.COM_PORT , value: 'value');
                        DialogBarForInfoAndAlert(context, title: "Connection", message: "Connection Details have been saved");
                      }),
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }
}
