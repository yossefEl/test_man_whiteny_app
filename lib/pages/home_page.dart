import 'package:analyse_donnees_app/components/card.dart';
import 'package:analyse_donnees_app/components/custom_dialog.dart';
import 'package:analyse_donnees_app/pages/screens/getting_data_methods_screen.dart';
import 'package:analyse_donnees_app/pages/screens/insert_data_screen.dart';
import 'package:analyse_donnees_app/utils/config_size.dart';
import 'package:flutter/material.dart';
import '../utils/colors.dart' as colors;
import 'screens/result_screen.dart';
import 'screens/upload_screen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  TabController tabController;
  
  @override
  void initState() {
    tabController = TabController(length:4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:()=> sureToExit(context),
      child: Scaffold(
          backgroundColor: colors.bgColor,
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              GettingDataMethodsScreen(tabController),
              UploadScreen(tabController),
              ResultScreen(tabController),
              InsertDataScreen(tabController)
            ],
            controller: tabController,
          )),
    );
  }
}

sureToExit(BuildContext context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialog();
      });
}
