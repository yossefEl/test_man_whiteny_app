import 'dart:collection';

import 'package:analyse_donnees_app/blocs/data_bloc.dart';
import 'package:analyse_donnees_app/components/card.dart';
import 'package:analyse_donnees_app/enums/file_loading_state_enum.dart';
import 'package:analyse_donnees_app/enums/group_enum.dart';
import 'package:analyse_donnees_app/models/data_pos_model.dart';
import 'package:analyse_donnees_app/utils/config_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import '../../utils/styles.dart' as styles;
import '../../utils/colors.dart' as colors;

class ResultScreen extends StatefulWidget {
  final TabController tabController;
  ResultScreen(this.tabController);
  @override
  _ResultScreenState createState() => _ResultScreenState(tabController);
}

class _ResultScreenState extends State<ResultScreen> {
  TabController tabController;
  _ResultScreenState(this.tabController);
  List<TableRow> dataList = [
    TableRow(children: [
      TableCell(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(child: Text("Data", style: styles.tableHeader)),
        ),
      ),
      TableCell(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(child: Text("X(A)", style: styles.tableHeader)),
        ),
      ),
      TableCell(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(child: Text("X(B)", style: styles.tableHeader)),
        ),
      ),
    ])
  ];
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      var dataBloc = Provider.of<DataBloc>(context);
     setState(() {
        if (dataBloc.getDataList.length != 0) {
        for (DataPositionModel item in dataBloc.getDataList) {
          dataList.add(TableRow(children: [
            TableCell(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                    child: Text(item.getDataItem.value.toString() ?? "value")),
              ),
            ),
            TableCell(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                    child: Text(item.getDataItem.group == Group.groupA
                        ? item.getPosition.toString()
                        : "-")),
              ),
            ),
            TableCell(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                    child: Text(item.getDataItem.group == Group.groupB
                        ? item.getPosition.toString()
                        : "-")),
              ),
            ),
          ]));
        }
      }
     });
setState(() {
  dataList.add(TableRow(children: [
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child: Text(
              "u",
              style: styles.tableHeader,
            )),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: Text(dataBloc.getMuGroupA.toString() ?? "-")),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: Text(dataBloc.getMuGroupB.toString() ?? "-")),
          ),
        ),
      ]));
      dataList.add(TableRow(children: [
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child: Text(
              "U",
              style: styles.tableHeader,
            )),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: Text(dataBloc.getUGroupA.toString() ?? "-")),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: Text(dataBloc.getUGroupB.toString() ?? "-")),
          ),
        ),
      ]));
});
      
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DataBloc>(builder: (context, dataBloc, _) {
      return Scaffold(
        backgroundColor: colors.bgColor,
        appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              "Results",
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                dataBloc.setFileLoadingState = FileLoadingState.none;
                dataBloc.initLists();
                setState(() {
                  tabController.animateTo(tabController.index -1);
                });
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            )),
        body: ListView(
          itemExtent: null,
          physics: AlwaysScrollableScrollPhysics(),
          children: <Widget>[
            Center(
              child: CustomCard(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView(
                      shrinkWrap: true,
                      itemExtent: null,
                      physics: NeverScrollableScrollPhysics(),
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                              child: Text(
                            "Data Table:",
                            style: styles.cardTitle
                          )),
                        ),
                        dataBloc.getDataList.length == 0
                            ? Center(
                                child: Container(
                                    padding: EdgeInsets.all(16),
                                    child: Column(
                                      children: <Widget>[
                                        Icon(
                                          Icons.data_usage,
                                          size: 50,
                                        ),
                                        Text("No data to show",
                                            style: TextStyle(fontSize: 15)),
                                      ],
                                    )))
                            : Table(
                              children: dataList,
                                border: TableBorder.all(
                                    color: Colors.black, width: 2),
                              ),

                      ],
                    ),
                  ),
                ),
              ),
            ),

           
              dataBloc.getUMin==null?Container(height: 0,width: 0,)
              :CustomCard(
                height: ConfigSize.screenHeight*0.2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("U(min) is :",style:styles.cardTitle),
                  SizedBox(height: 5,),
                  Text(
                    dataBloc.getUMin.toString()??"Something went wrong!",
                    style:styles.cardTitle
                  )

                ],
              ),
              )
          ],
        ),
      );
    });
  }
}
