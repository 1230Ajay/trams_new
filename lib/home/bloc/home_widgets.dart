import 'dart:math';

import 'package:battery_indicator/battery_indicator.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:toggle_switch/toggle_switch.dart';
import 'package:untitled2/common/colors/colors.dart';
import 'package:untitled2/home/bloc/home_bloc.dart';
import 'package:untitled2/home/bloc/home_events.dart';
import 'package:untitled2/home/bloc/home_states.dart';
import 'package:untitled2/home/home_controller.dart';

import '../../common/controller/global_controller.dart';
import '../../common/values/widgets.dart';
import '../settings/widgets/setting_widgets.dart';

Widget logo() {
  return Container(
    child: Row(
      children: [
        Image.asset(
          "assets/images/indian_railways_logo.png",
          height: 60,
        ),
        SizedBox(
          width: 8,
        ),
        Image.asset(
          "assets/images/tram.png",
          height: 60,
        )
      ],
    ),
  );
}

Widget batteryAndDateTime(dynamic data) {
  return Row(
    children: [
      Text(
        "${data?.dateTime?.year.toString()}-${data?.dateTime?.month.toString()}-${data?.dateTime?.day.toString()} ${data?.dateTime?.hour.toString()}:${data?.dateTime?.minute.toString()}:${data?.dateTime?.second.toString()}",
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(width: 12),
      Text(
        "${data.battery.toString()}%",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(width: 8),
      BatteryIndicator(
        batteryLevel: data.battery ?? 0,
        style: BatteryIndicatorStyle.skeumorphism,
        ratio: 1.8,
        showPercentNum: false,
      )
    ],
  );
}

Widget PrimaryButton({required String btnName, void Function()? onPress}) {
  return Container(
    decoration: BoxDecoration(
        color: AppColors.primaryText, borderRadius: BorderRadius.circular(8)),
    height: 48,
    width: 120,
    child: GestureDetector(
      onTap: () => onPress!(),
      child: Center(
        child: Text(
          btnName,
          style: TextStyle(
              color: AppColors.primaryElement,
              fontWeight: FontWeight.bold,
              fontSize: 18),
        ),
      ),
    ),
  );
}

Widget PrimaryToggleButton(
    {required String firstBtnName,
    required String secondBtnName,
    void Function()? onPress,
    required HomeStates state}) {
  return GestureDetector(
    onTap: () {
      onPress!();
    },
    child: Container(
      decoration: BoxDecoration(
          color: AppColors.primaryElement,
          borderRadius: BorderRadius.circular(8)),
      height: 48,
      width: 190,
      child: Center(
        child: Text(
          state.isStarted! ? secondBtnName : firstBtnName,
          style: TextStyle(
              color: AppColors.primaryElementText,
              fontWeight: FontWeight.bold,
              fontSize: 18),
        ),
      ),
    ),
  );
}

Widget rightnav(HomeController homeController, BuildContext context) {
  return Row(
    children: [
      StreamBuilder(
        stream: homeController.dateTime(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show a loading indicator while waiting for data
            return Container();
          } else {
            // If data is available, show the counter value
            return batteryAndDateTime(snapshot.data);
          }
        },
      ),
      SizedBox(
        width: 12,
      ),
      SizedBox(
        width: 12,
      ),
      IconButton(
          icon: Icon(Icons.settings),
          onPressed: () {
            showPopup(context);
          }),
      SizedBox(
        width: 12,
      ),
      CircleAvatar(
          radius: 24, backgroundColor: Colors.white, child: Winndowbar())
    ],
  );
}

Widget MyAppBar(HomeController homeController, BuildContext context) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        logo(),
        rightnav(
          homeController,
          context,
        ),
      ],
    ),
  );
}

Widget Dials(
    {required int angle,
    List<String>? numbers,
    required String name,
    String unit = "mm",
    bool isTwoTypeValue = false,
    String valueForLeft = "L",
    String valueForRight = "R", required int value}) {
  return Container(
    height: 200,
    width: 200,
    child: Stack(
      alignment: Alignment.center,
      children: [
        Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFCADBEB),
                    Color(0xFFCADBFB),
                  ]),
              boxShadow: [
                BoxShadow(
                    color: Color(0xFF3f6080).withOpacity(.2),
                    blurRadius: 32,
                    offset: Offset(40, 20)),
                BoxShadow(
                    color: Color(0xFFFFFFFF),
                    blurRadius: 32,
                    offset: Offset(-20, -10))
              ]),
        ),
        Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
        ),
        Transform.rotate(
          angle: 11.79,
          child: Container(
            constraints: BoxConstraints.expand(),
            child: CustomPaint(
              painter: numbers != null
                  ? ClockPainter(angle: angle, numbers: numbers)
                  : ClockPainter(
                      angle: angle,
                    ),
            ),
          ),
        ),
        Container(
            width: 144,
            height: 144,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.secondaryColor,
            ),
            child: Container(
              padding: EdgeInsets.only(top: 32),
              child: Column(
                children: [
                  Text(
                    isTwoTypeValue
                        ? (value == 0
                            ? value.toString()
                            : value < 0
                                ? "${(value * (-1)).toString()}${valueForLeft}"
                                : "${value.toString()}${valueForRight}")
                        : value.toString(),
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  Text(name,
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                  Text(
                    unit,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            )),
      ],
    ),
  );
}

Widget Dials2(
    {required int angle,
    List<String>? numbers,
    required String name,
    required String unit}) {
  return Container(
    height: 200,
    width: 200,
    child: Stack(
      alignment: Alignment.center,
      children: [
        Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFCADBEB),
                    Color(0xFFCADBFB),
                  ]),
              boxShadow: [
                BoxShadow(
                    color: Color(0xFF3f6080).withOpacity(.2),
                    blurRadius: 32,
                    offset: Offset(40, 20)),
                BoxShadow(
                    color: Color(0xFFFFFFFF),
                    blurRadius: 32,
                    offset: Offset(-20, -10))
              ]),
        ),
        Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
        ),
        Transform.rotate(
          angle: 11.79,
          child: Container(
            constraints: BoxConstraints.expand(),
            child: CustomPaint(
              painter: numbers != null
                  ? ClockPainter2(angle: angle, numbers: numbers)
                  : ClockPainter2(
                      angle: angle,
                    ),
            ),
          ),
        ),
        Container(
            width: 144,
            height: 144,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.secondaryColor,
            ),
            child: Container(
              padding: EdgeInsets.only(top: 32),
              child: Column(
                children: [
                  Text(
                    angle.toString(),
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  Text(name,
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                  Text(
                    unit,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            )),
      ],
    ),
  );
}

Widget dialList({required HomeController controller}) {
  return StreamBuilder(
      stream: controller.readData(),
      builder: (context, snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 60, vertical: 60),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Dials(
                      value: snapshot.data == null ? 0 : snapshot.data!.level!,
                      angle: snapshot.data == null ? 0 : snapshot.data!.gauge!,
                      name: "GAUGE"),
                  Dials(
                      value:snapshot.data == null ? 0 : snapshot.data!.level!,
                      angle: snapshot.data == null ? 0 : snapshot.data!.level!,
                      name: "LEVEL",
                      isTwoTypeValue: true),
                  Dials(
                      value:snapshot.data == null ? 0 : snapshot.data!.gradient!*100,
                      angle:
                          snapshot.data == null ? 0 : snapshot.data!.gradient!,
                      numbers: [
                        "  -1.5k",
                        "-1k",
                        "-0.5k",
                        "   0",
                        "0.5k",
                        "1k",
                        "1.5k"
                      ],
                      name: "GRADIENT",
                      unit: "Meter",
                      isTwoTypeValue: true,
                      valueForLeft: "F",
                      valueForRight: "R"),
                ],
              ),
              SizedBox(
                height: 72,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Dials(
                    value: snapshot.data == null ? 0 : snapshot.data!.twist!,
                      angle: snapshot.data == null ? 0 : snapshot.data!.twist!-15,
                      numbers: [
                        "  0",
                        "    5",
                        "10",
                        " 15",
                        "   20",
                        " 25",
                        "30"
                      ],
                      name: "TWIST",
                      unit: "mm/M"),
                  Dials2(
                      angle: snapshot.data == null ? 0 : snapshot.data!.temp!,
                      numbers: [
                        " -5",
                        "15",
                        "25",
                        " 35",
                        "   45",
                        " 55",
                        "65",
                        " 75",
                        " 85",
                        "95"
                      ],
                      name: "TEMP",
                      unit: "°C"),
                  Dials2(
                      angle: snapshot.data == null ? 0 : snapshot.data!.speed!,
                      numbers: [
                        "  0",
                        "10",
                        "20",
                        " 30",
                        "   40",
                        " 50",
                        "60",
                        " 70",
                        " 80",
                        " 90"
                      ],
                      name: "SPEED",
                      unit: "KM/H"),
                ],
              ),
            ],
          ),
        );
      });
}

class ClockPainter extends CustomPainter {
  int angle;
  List<String> numbers;
  ClockPainter(
      {this.angle = 0,
      this.numbers = const [
        "  -15",
        "-10",
        "-5",
        "   0",
        "    5",
        " 10",
        "15"
      ]});

  @override
  void paint(Canvas canvas, Size size) {
    double centerX = size.width / 2;
    double centerY = size.height / 2;
    Offset center = Offset(centerX, centerY);
    double radius = min(centerX + 38, centerY + 38);
    double OuterRadius = radius - 20;
    double InnerRatius = radius - 32;

    Paint DashPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < 271; i += 45) {
      double x1 = centerX - OuterRadius * cos(i * pi / 180);
      double y1 = centerX - OuterRadius * sin(i * pi / 180);

      double x2 = centerX - InnerRatius * cos(i * pi / 180);
      double y2 = centerX - InnerRatius * sin(i * pi / 180);

      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), DashPaint);
    }

    Paint InnerDashPaint = Paint()
      ..color = AppColors.primaryText
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < 270; i += 9) {
      double x1 = centerX - OuterRadius * .95 * cos(i * pi / 180);
      double y1 = centerX - OuterRadius * .95 * sin(i * pi / 180);

      double x2 = centerX - InnerRatius * cos(i * pi / 180);
      double y2 = centerX - InnerRatius * sin(i * pi / 180);

      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), InnerDashPaint);
    }

    final double angleStep = 360 / 8.2;

    final TextPainter textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    for (int i = 0; i < numbers.length; i++) {
      final double angle = 3.195 + i * angleStep * pi / 180;
      final double x = (centerX + 3) + radius * cos(angle);
      final double y = (centerY - 4) + radius * sin(angle);

      final double textX = x - 10; // Adjust text position
      final double textY = y - 10; // Adjust text position

      textPainter.text = TextSpan(
        text: numbers[i],
        style: TextStyle(fontSize: 16.0, color: AppColors.primaryText),
      );

      textPainter.layout();

      // Wrap TextPainter with Transform.rotate to apply rotation
      canvas.save();
      canvas.translate(textX, textY);
      canvas.rotate(.75); // Use the angle to rotate the text
      textPainter.paint(canvas, Offset(0, 0));
      canvas.restore();
    }

    double rotate = 15 + angle.toDouble();

    Paint secLinePaint = Paint()
      ..color = AppColors.primaryElement
      ..strokeWidth = 14
      ..strokeCap = StrokeCap.round;

    Offset secStartOffset = Offset(
      centerX - 20 * cos(rotate * 9 * pi / 180),
      centerY - 20 * sin(rotate * 9 * pi / 180),
    );

    Offset secEndOffset = Offset(
      centerX - (OuterRadius - 34) * cos(rotate * 9 * pi / 180),
      centerY - (OuterRadius - 34) * sin(rotate * 9 * pi / 180),
    );

    Paint centerCireclePaint = Paint()..color = Color(0xFFE81466);

    canvas.drawLine(secStartOffset, secEndOffset, secLinePaint);
    canvas.drawCircle(center, 12, centerCireclePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class ClockPainter2 extends CustomPainter {
  int angle;
  List<String> numbers;
  ClockPainter2(
      {this.angle = 0,
      this.numbers = const [
        "  -15",
        "-10",
        "-5",
        "  0",
        "    5",
        " 10",
        "15"
      ]});

  @override
  void paint(Canvas canvas, Size size) {
    double centerX = size.width / 2;
    double centerY = size.height / 2;
    Offset center = Offset(centerX, centerY);
    double radius = min(centerX + 38, centerY + 38);
    double OuterRadius = radius - 20;
    double InnerRatius = radius - 32;

    Paint DashPaint = Paint()
      ..color = AppColors.primaryText
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < 271; i += 30) {
      double x1 = centerX - OuterRadius * cos(i * pi / 180);
      double y1 = centerX - OuterRadius * sin(i * pi / 180);

      double x2 = centerX - InnerRatius * cos(i * pi / 180);
      double y2 = centerX - InnerRatius * sin(i * pi / 180);

      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), DashPaint);
    }

    Paint InnerDashPaint = Paint()
      ..color = AppColors.primaryText
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < 270; i += 3) {
      double x1 = centerX - OuterRadius * .95 * cos(i * pi / 180);
      double y1 = centerX - OuterRadius * .95 * sin(i * pi / 180);

      double x2 = centerX - InnerRatius * cos(i * pi / 180);
      double y2 = centerX - InnerRatius * sin(i * pi / 180);

      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), InnerDashPaint);
    }

    final double angleStep = 360 / 12;

    final TextPainter textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    for (int i = 0; i < numbers.length; i++) {
      final double angle = 3.115 + i * angleStep * pi / 180;
      final double x = (centerX + 3) + radius * cos(angle);
      final double y = (centerY - 4) + radius * sin(angle);

      final double textX = x - 10; // Adjust text position
      final double textY = y - 10; // Adjust text position

      textPainter.text = TextSpan(
        text: numbers[i],
        style: TextStyle(fontSize: 16.0, color: AppColors.primaryText),
      );

      textPainter.layout();

      // Wrap TextPainter with Transform.rotate to apply rotation
      canvas.save();
      canvas.translate(textX, textY);
      canvas.rotate(.75); // Use the angle to rotate the text
      textPainter.paint(canvas, Offset(0, 0));
      canvas.restore();
    }

    double rotate = angle.toDouble();

    Paint secLinePaint = Paint()
      ..color = AppColors.primaryElement
      ..strokeWidth = 14
      ..strokeCap = StrokeCap.round;

    Offset secStartOffset = Offset(
      centerX - 20 * cos(rotate * 3 * pi / 180),
      centerY - 20 * sin(rotate * 3 * pi / 180),
    );

    Offset secEndOffset = Offset(
      centerX - (OuterRadius - 34) * cos(rotate * 3 * pi / 180),
      centerY - (OuterRadius - 34) * sin(rotate * 3 * pi / 180),
    );

    Paint centerCireclePaint = Paint()..color = Color(0xFFE81466);

    canvas.drawLine(secStartOffset, secEndOffset, secLinePaint);
    canvas.drawCircle(center, 12, centerCireclePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

Widget MyFooter(
    HomeController homeController, HomeStates state, BuildContext context) {
  return StreamBuilder(
      stream: homeController.getLocation(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else {
          return Container(
            margin: EdgeInsets.only(left: 6, right: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/rki_logo.png",
                  height: 56,
                  width: 340,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "ZONE : ${snapshot.data?["zone"]}",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text(
                      "DIV : ${snapshot.data?["division"]}",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "SECTION : ${snapshot.data?["section"]}",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text(
                      "OPERATOR : ${"AJAY MALAH"}",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ],
                ),
                SizedBox(
                  child: IconButton(
                      icon: Icon(Icons.share_location_outlined),
                      onPressed: () {
                        showInputPopup(context,
                            onSave: (value) async {
                              DialogBarForInfoAndAlert(context, title:"Data Saved", message: "RDPS Details have Saved");
                            }, name: 'RDPS');
                      }),
                ),
                PrimaryToggleButton(
                    firstBtnName: "START",
                    secondBtnName: "STOP",
                    onPress: () {
                      context.read<HomeBloc>().add(isStartedEvents(
                          isStarted: state.isStarted! ? false : true));
                      print("${state.isStarted}");
                    },
                    state: state)
              ],
            ),
          );
        }
      });
}

Widget rightHome(HomeController homeController) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.end,
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Container(
        // color: Colors.red,
        height: 200,
        width: 200,
        child: Center(
          child: Text("Live Video Recording"),
        ),
      ),
      Container(
        width: 200,
        child: Column(
          children: [
            Text(
              "GPS CORDINATES",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Lattitude",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text("Longitude",
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            StreamBuilder(
                stream: homeController.getLocationCordinatesLive(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: Container(
                        height: 24,width: 24,
                        child: CircularProgressIndicator()));
                  } else {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                            color: AppColors.primaryElement,
                            width: 88,
                            padding: EdgeInsets.symmetric(vertical: 2),
                            child: Center(
                                child: Text(
                              snapshot.data?["lat"],
                              style: TextStyle(
                                  color: AppColors.primaryElementText,
                                  fontWeight: FontWeight.bold),
                            ))),
                        Container(
                            color: AppColors.primaryElement,
                            width: 88,
                            padding: EdgeInsets.symmetric(vertical: 2),
                            child: Center(
                                child: Text(snapshot.data?["long"],
                                    style: TextStyle(
                                        color: AppColors.primaryElementText,
                                        fontWeight: FontWeight.bold)))),
                      ],
                    );
                  }
                }),
            SizedBox(
              height: 48,
            ),
            Text("DISTANCE",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Absolute", style: TextStyle(fontWeight: FontWeight.bold)),
                Text("Relative", style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                    color: AppColors.primaryElement,
                    width: 88,
                    padding: EdgeInsets.symmetric(vertical: 2),
                    child: Center(
                        child: Text("NA",
                            style: TextStyle(
                                color: AppColors.primaryElementText,
                                fontWeight: FontWeight.bold)))),
                Container(
                    color: AppColors.primaryElement,
                    width: 88,
                    padding: EdgeInsets.symmetric(vertical: 2),
                    child: Center(
                        child: Text("NA",
                            style: TextStyle(
                                color: AppColors.primaryElementText,
                                fontWeight: FontWeight.bold)))),
              ],
            )
          ],
        ),
      ),
    ],
  );
}

Widget Winndowbar() {
  return WindowTitleBarBox(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(child: MoveWindow()),
        CloseWindowButton(
          colors: WindowButtonColors(
              mouseOver: Colors.transparent,
              mouseDown: Colors.transparent,
              iconNormal: AppColors.primaryText,
              iconMouseOver: AppColors.primaryText),
        ),
      ],
    ),
  );
}
