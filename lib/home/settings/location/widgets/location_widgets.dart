import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/home/settings/location/bloc/location_bloc.dart';
import 'package:untitled2/home/settings/widgets/setting_widgets.dart';

import '../../../../common/colors/colors.dart';

class LocationTile extends StatefulWidget {
  List<dynamic> dataList;
  String hintText;
  String name;
  Function(String value) onSelect;
  Function() add;
  Function() onDelete;

  LocationTile(
      {super.key,
      required this.dataList,
      required this.hintText,
      required this.name,
      required this.add,
      required this.onSelect,
      required this.onDelete});

  @override
  State<LocationTile> createState() => _LocationTileState();
}

class _LocationTileState extends State<LocationTile> {
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              isOpen?Container():Container(
                margin: EdgeInsets.only(bottom: 12),
                width: 200,
                child: reUsableText(name: "${widget.name} :",color: AppColors.primarySecondaryElementText,fontWeight: FontWeight.w500,fontSize: 18),),

              isOpen
                  ? Container()
                  : GestureDetector(
                      onTap: () {
                        setState(() {
                          if(widget.name=="Zone"){
                          isOpen = !isOpen;
                          }else if(widget.name=="Division"){
                           if(context.read<LocationBloc>().state.zone!=""){
                             isOpen = !isOpen;
                           };
                          }else if(widget.name=="Section"){
                            if(context.read<LocationBloc>().state.division!=""){
                              isOpen = !isOpen;
                            };
                          }
                        });
                      },
                      child: Container(
                        width: 200,
                        height: 48,
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        decoration: BoxDecoration(
                          color: AppColors.primaryElementText,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.secondaryColor,
                              spreadRadius: 2,
                              blurRadius: 3,
                            )
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            reUsableText(
                                name: widget.hintText,
                                color: AppColors.primarySecondaryElementText,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                            Container(
                              child: Icon(Icons.keyboard_arrow_down),
                            )
                          ],
                        ),
                      ),
                    ),
              isOpen
                  ? Container(
                      width: 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 12),
                            height: 32,
                            width: 200,
                            decoration: BoxDecoration(
                              color: AppColors.primaryElementText,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.secondaryColor,
                                  spreadRadius: 2,
                                  blurRadius: 3,
                                )
                              ],
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.add,
                                  size: 16,
                                  color: AppColors.primarySecondaryElementText,
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                GestureDetector(
                                  onTap:widget.add,
                                  child: reUsableText(
                                      name: "add ${widget.name}",
                                      fontWeight: FontWeight.w500,
                                      color:
                                          AppColors.primarySecondaryElementText),
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 3),
                            height: 100,
                            child: SingleChildScrollView(
                              child: ListView.builder(
                                  primary: true,
                                  shrinkWrap: true,
                                  itemCount: widget.dataList.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                        onTap: () {
                                          widget
                                              .onSelect(widget.dataList[index].name);
                                          setState(() {
                                            widget.hintText =
                                                widget.dataList[index].name;
                                            isOpen = !isOpen;
                                          });
                                        },
                                        child: Container(
                                          padding: EdgeInsets.only(left: 12),
                                          height: 32,
                                          decoration: BoxDecoration(
                                            color:AppColors.primaryElementText,
                                            boxShadow: [
                                              BoxShadow(
                                                color: AppColors.secondaryColor,
                                                spreadRadius: 2,
                                                blurRadius: 3,
                                              )
                                            ],
                                          ),
                                          child: reUsableText(
                                              name: widget.dataList[index].name,
                                              fontWeight: FontWeight.w500,
                                              color: AppColors
                                                  .primarySecondaryElementText),
                                        ));
                                  }),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container()
            ],
          ),
        ),
      ],
    );
  }
}


  // Function to show the reusable popup

