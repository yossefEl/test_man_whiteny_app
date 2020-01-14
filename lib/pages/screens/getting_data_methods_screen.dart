import 'package:analyse_donnees_app/components/card.dart';
import 'package:analyse_donnees_app/components/primary_button.dart';
import 'package:analyse_donnees_app/utils/config_size.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GettingDataMethodsScreen extends StatefulWidget {
  final TabController tabController;
  GettingDataMethodsScreen(this.tabController);
  @override
  _GettingDataMethodsScreenState createState() =>
      _GettingDataMethodsScreenState(tabController);
}

class _GettingDataMethodsScreenState extends State<GettingDataMethodsScreen> {
  TabController tabController;
  var noFilePicked = true;

  String errorMessage;
  _GettingDataMethodsScreenState(this.tabController);
  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Positioned(
        child: Align(
          alignment: Alignment.center,
          child: CustomCard(
            height: ConfigSize.screenHeight * 0.5,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "Choose one of these \nmethods to enter your raw data",
                        textAlign: TextAlign.center,
                      )),
                  PrimaryButton(
                    padding: const EdgeInsets.all(8),
                    icon: Icons.create,
                    title: "Insert data",
                    textColor: Colors.white,
                    borderRadius: 10,
                    width: ConfigSize.screenHeight*0.4,
                    onTap:  () {
                      tabController.animateTo(tabController.index+3);
                    },
                    buttonColor: Colors.black,
                  ),
                  SizedBox(height: 10,),
                  PrimaryButton(
                    padding: const EdgeInsets.all(8),
                    icon: Icons.insert_drive_file,
                    title: "Upload a JSON file",
                    textColor: Colors.white,
                    borderRadius: 10,
                    width: ConfigSize.screenHeight*0.4,
                    onTap: () {
                      tabController.animateTo(tabController.index+1%2);
                    },
                    buttonColor: Colors.black,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      Positioned(
        top: (ConfigSize.screenHeight * 0.27) / 2,
        left: (ConfigSize.screenWidth - 150) / 2,
        child: Align(
            alignment: Alignment.center,
            child: Hero(
              tag: 'logo_app',
              child: Image.asset(
                'assets/images/logo.png',
                height: 150,
              ),
            )),
      ),
    ]);
  }
}
