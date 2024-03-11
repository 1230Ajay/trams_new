

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled2/common/colors/colors.dart';
import 'package:untitled2/home/settings/widgets/setting_widgets.dart';

Widget RecordingHeaderTile({required String fileName,required String zone,required String section,required String timeStamp}){
  return Container(
    margin: EdgeInsets.only(bottom: 2),
    color: AppColors.primaryElement,
    height: 36,
    padding: EdgeInsets.symmetric(horizontal: 8),
    child: Row(children: [
      Expanded(child: reUsableText(name: fileName,fontSize: 14,fontWeight: FontWeight.bold,color: AppColors.primaryElementText)),
      Expanded(child: reUsableText(name: zone,fontSize: 14,fontWeight: FontWeight.bold,color: AppColors.primaryElementText)),
      Expanded(child: reUsableText(name: section,fontSize: 14,fontWeight: FontWeight.bold,color: AppColors.primaryElementText)),
      Expanded(child: reUsableText(name: timeStamp,fontSize: 14,fontWeight: FontWeight.bold,color: AppColors.primaryElementText)),
      SizedBox(width: 32,)
    ],),
  );
}

Widget RecordingTile({required String fileName,required String zone,required String section,required String timeStamp,void Function()? onPress}){
  return Container(
    height: 36,
    padding: EdgeInsets.symmetric(horizontal: 8),
    child: Row(children: [
      Expanded(child: reUsableText(name: fileName,fontSize: 14,fontWeight: FontWeight.w600)),
      Expanded(child: reUsableText(name: zone,fontSize: 14,fontWeight: FontWeight.w600)),
      Expanded(child: reUsableText(name: section,fontSize: 14,fontWeight: FontWeight.w600)),
      Expanded(child: reUsableText(name: timeStamp,fontSize: 14,fontWeight: FontWeight.w600)),
      Container(
        width: 32,
        child: IconButton(
          onPressed: ()=>onPress!(), icon: Icon(Icons.delete,color: AppColors.primaryElement,),
          
        ),
      )
    ],),
  );
}