import 'package:flutter/material.dart';
import 'package:untitled2/common/colors/colors.dart';
import 'package:untitled2/home/settings/recordings/widgets/recording_widgets.dart';
import 'package:untitled2/home/settings/widgets/setting_widgets.dart';

class Recodrings extends StatefulWidget {
  const Recodrings({super.key});

  @override
  State<Recodrings> createState() => _RecodringsState();
}

class _RecodringsState extends State<Recodrings> {
  @override
  Widget build(BuildContext context) {
    return SettingPageScreens(
        title: "Recording",
        child: Column(
          children: [
            Container(
              margin:EdgeInsets.only(top: 12),
              height: 300,
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: RecordingHeaderTile(fileName: "File name",zone: "Zone",section: "Section",timeStamp: "Time"),
                  ),

                  SliverList(
                      delegate:SliverChildBuilderDelegate(
                              childCount: 54,
                              (context, index) => RecordingTile(fileName: "rec", zone: "Zone 1", section: "Sec 1", timeStamp: "2024-4-30 12:24:09"))),
                ],
              ),
            ),

              Container(
              margin: EdgeInsets.only(top:12),
              height: 3,
              color: AppColors.primaryElement,),
          ],
        )
    );
  }
}
