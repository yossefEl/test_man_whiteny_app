import 'dart:io';

import 'package:analyse_donnees_app/blocs/data_bloc.dart';
import 'package:analyse_donnees_app/components/card.dart';
import 'package:analyse_donnees_app/components/primary_button.dart';
import 'package:analyse_donnees_app/enums/calculationg_data_enum.dart';
import 'package:analyse_donnees_app/enums/file_loading_state_enum.dart';
import 'package:analyse_donnees_app/utils/config_size.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UploadScreen extends StatefulWidget {
  final TabController tabController;
  UploadScreen(this.tabController);
  @override
  _UploadScreenState createState() => _UploadScreenState(tabController);
}

class _UploadScreenState extends State<UploadScreen> {
  TabController tabController;
  var noFilePicked = true;

  String errorMessage;
  _UploadScreenState(this.tabController);
  File file;
  @override
  Widget build(BuildContext context) {
    var dataBloc = Provider.of<DataBloc>(context);
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
                  Icon(Icons.insert_drive_file,size: 70,color: Colors.black),
                  Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: dataBloc.getFileLoadingState ==
                              FileLoadingState.none
                          ? RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                text:
                                    'Please upload a JSON file from your phone containing the two Group with ',
                                style: TextStyle(color: Colors.black),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: 'A',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text:
                                          ' as a name for the first and for the second one use '),
                                  TextSpan(
                                      text: 'B',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            )
                          : dataBloc.getFileLoadingState ==
                                  FileLoadingState.error
                              ? Text(dataBloc.getFileLoadingMessageError)
                              : dataBloc.getFileLoadingState ==
                                      FileLoadingState.loading
                                  ? CircularProgressIndicator()
                                  : Center(
                                      child: Column(
                                        children: <Widget>[
                                          Icon(
                                            Icons.done,
                                            size: 50,
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text("Processing data.."),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          SizedBox(
                                              width:
                                                  ConfigSize.screenWidth * 0.4,
                                              child: LinearProgressIndicator(
                                                backgroundColor: Colors.black,
                                              ))
                                        ],
                                      ),
                                    )),
                  PrimaryButton(
                    onTap: () async {
                      dataBloc.setFileLoadingState = FileLoadingState.loading;
                      await dataBloc.loadFile();
                      if (dataBloc.getFileLoadingState ==
                          FileLoadingState.done) {
                        Future.delayed(Duration(seconds: 2), () {
                          tabController.animateTo(
                            tabController.index +1,
                          );
                        });
                      }
                    },
                    padding:EdgeInsets.all(13),
                    width: ConfigSize.screenWidth * 0.5,
                    buttonColor: Colors.black,
                    icon: Icons.file_upload,
                    iconColor: Colors.white,
                    textColor: Colors.white,
                    borderRadius: 10,
                    title: "Upload JSON file",
                  ),

                  IconButton(
                    onPressed: (){
                      tabController.animateTo(tabController.index-1);
                    },
                    iconSize: 20,
                    icon: Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.black,
                      ),
                      
                      
                      child: Center(child: Icon(Icons.arrow_back_ios,color: Colors.white))),
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
