import 'dart:io';

import 'package:analyse_donnees_app/components/primary_button.dart';
import 'package:analyse_donnees_app/utils/config_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/styles.dart' as styles;
class CustomDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Colors.white,
          child: Container(
    height: ConfigSize.screenHeight*0.4,        
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.exit_to_app,size: 50,color: Colors.redAccent),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(child: Text("Are you sure to exit the app",style:styles.dialogText,)),
                ),
                SizedBox(height:5),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    PrimaryButton(
                      padding: const EdgeInsets.all(8),
                      icon: Icons.check,
                      title: "No",
                      textColor: Colors.white,
                      borderRadius: 10,
                      width: 100,
                      onTap: (){Navigator.of(context).pop();},
                    ),
                     PrimaryButton(
                       padding: const EdgeInsets.all(8),
                      icon: Icons.check,
                      title: "Yes",
                      textColor: Colors.white,
                      borderRadius: 10,
                      width: 100,
                      onTap: (){SystemChannels.platform.invokeMethod('SystemNavigator.pop');},
                      buttonColor: Colors.grey[400],
                    ),
                  ],
                )
              ],

            ),
          ),
        );
  }
}