import 'dart:io';
import 'package:analyse_donnees_app/components/card.dart';
import 'package:analyse_donnees_app/components/primary_button.dart';

import 'package:analyse_donnees_app/utils/config_size.dart';
import 'package:flutter/material.dart';

class InsertDataScreen extends StatefulWidget {
  final TabController tabController;
  InsertDataScreen(this.tabController);
  @override
  _InsertDataScreenState createState() => _InsertDataScreenState(tabController);
}

class _InsertDataScreenState extends State<InsertDataScreen> {
  TabController tabController;
  bool invA = false, invB = false;

  String errorMessage;
  _InsertDataScreenState(this.tabController);
  File file;
  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Positioned(
        child: Align(
          alignment: Alignment.center,
          child: CustomCard(
            height: ConfigSize.screenHeight * 0.6,
            child: Center(
              child: ListView(
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Icon(Icons.create, size: 70, color: Colors.black),
                      Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                              "Please enter the number of\n elements for A and B series")
                          //  Center(
                          //     child: Column(
                          //       children: <Widget>[
                          //         Icon(
                          //           Icons.done,
                          //           size: 50,
                          //         ),
                          //         SizedBox(
                          //           height: 5,
                          //         ),
                          //         Text("Processing data.."),
                          //         SizedBox(
                          //           height: 5,
                          //         ),
                          //         SizedBox(
                          //             width:
                          //                 ConfigSize.screenWidth * 0.4,
                          //             child: LinearProgressIndicator(
                          //               backgroundColor: Colors.black,
                          //             ))
                          //       ],
                          //     ),
                          // )
                          ),],),
                      
                         Form(
                          child: Column(
                             children: <Widget>[
                               Container(
                                 width: ConfigSize.screenWidth * 0.7,
                                 child: TextFormField(
                                     onChanged: (v) {
                                       if (int.parse(v) > 30) {
                                         setState(() {
                                           invA = true;
                                         });
                                       } else {
                                         setState(() {
                                           invA = false;
                                         });
                                       }
                                     },
                                     decoration: InputDecoration(
                                       hintText: "Group B length",
                                       errorText: invA
                                           ? 'This should be less than or equal to 30'
                                           : null,
                                     )),
                               ),
                               Container(
                                 width: ConfigSize.screenWidth * 0.7,
                                 child: TextFormField(
                                   onChanged:(v) {
                                   if (int.parse(v) > 30) {
                                     setState(() {
                                       invB = true;
                                     });
                                   } else {
                                     setState(() {
                                       invB = false;
                                     });
                                   }
                                 },
                                     decoration: InputDecoration(
                                       hintText: "Group B length",
                                       errorText: invB
                                           ? 'This should be less than or equal to 30'
                                           : null,
                                     )),
                               ),
                             ],
                           ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                       Column(
                    children: <Widget>[
                      PrimaryButton(
                        onTap: () {},
                        padding: EdgeInsets.all(13),
                        width: ConfigSize.screenWidth * 0.5,
                        buttonColor: Colors.black,
                        icon: Icons.check,
                        iconColor: Colors.white,
                        textColor: Colors.white,
                        borderRadius: 10,
                        title: "Start processing",
                      ),
                      IconButton(
                        onPressed: () {
                          tabController.animateTo(tabController.index - 3);
                        },
                        iconSize: 20,
                        icon: Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.black,
                            ),
                            child: Center(
                                child: Icon(Icons.arrow_back_ios,
                                    color: Colors.white))),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      // Positioned(
      //   top: (ConfigSize.screenHeight * 0.27) / 2,
      //   left: (ConfigSize.screenWidth - 150) / 2,
      //   child: Align(
      //       alignment: Alignment.center,
      //       child: Hero(
      //         tag: 'logo_app',
      //         child: Image.asset(
      //           'assets/images/logo.png',
      //           height: 150,
      //         ),
      //       )),
      // ),
    ]);
  }
}
