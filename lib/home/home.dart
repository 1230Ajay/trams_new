import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import '../common/routes/routes.dart';
import 'bloc/home_bloc.dart';
import 'bloc/home_states.dart';
import 'bloc/home_widgets.dart';
import 'home_controller.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late HomeController _homeController;
  @override
  void initState() {
    super.initState();
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
     _homeController = HomeController(context);
     await _homeController.readData();
  }

  @override
  Widget build(BuildContext context) {
    int _selectedIndex =0;


    return MultiBlocProvider(providers: AppPages.allBlocProviders(context), child: BlocBuilder<HomeBloc,HomeStates>(builder: (context,state){
      return Scaffold(
        body:Container(
          child:
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(left: 24,right: 24,top: 12),
              child: Column(
                children: [
                  MyAppBar(_homeController,context),
                  Row(
                    children: [
                      Expanded(child:dialList(controller:_homeController),),
                      Container(
                        width: 256,
                        child: rightHome(_homeController),)
                    ],),

                  MyFooter(_homeController,state,context),

                ],
              ),
            ),
          )

        ) ,
      );
    }));
  }
}

