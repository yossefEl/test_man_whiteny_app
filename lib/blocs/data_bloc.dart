import 'dart:collection';
import 'dart:io';
import 'package:analyse_donnees_app/enums/calculationg_data_enum.dart';
import 'package:analyse_donnees_app/enums/file_loading_state_enum.dart';
import 'package:analyse_donnees_app/enums/group_enum.dart';
import 'package:analyse_donnees_app/models/data_item_model.dart';
import 'package:analyse_donnees_app/models/data_pos_model.dart';
import 'package:path/path.dart' as p;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';

class DataBloc with ChangeNotifier {
  File _file;
  String _fileLoadingErrorMessage = '';
  FileLoadingState _fileLoadingState = FileLoadingState.none;
  List<DataItem> _listOfItems = [];
  List<DataPositionModel> _listDataItemPosition = [];
  //using this formula: ( N*(N+1)  )/2
  //  we calculate the sum of each group
  double _sumPositionsGroupA = 0.0;
  double _sumPositionsGroupB = 0.0;
  double _muGroupA = 0.0;
  double _muGroupB = 0.0;
  double _uGroupA = 0.0;
  double _uGroupB = 0.0;
  double _uMin = 0.0;

  CalculatingDataState _calcutaringState;
  String _calculatingErrorMessage;

  double get getSumPositionsGroupA => _sumPositionsGroupA;
  double get getSumPositionsGroupB => _sumPositionsGroupB;
  double get getMuGroupA => _muGroupA;
  double get getMuGroupB => _muGroupB;
  double get getUGroupA => _uGroupA;
  double get getUGroupB => _uGroupB;
  double get getUMin => _uMin;
  CalculatingDataState get getCalcutaringState => _calcutaringState;
  String get getCalculatingErrorMessage => _calculatingErrorMessage;

  String get getFileLoadingMessageError => _fileLoadingErrorMessage??'';
  FileLoadingState get getFileLoadingState => _fileLoadingState;
  UnmodifiableListView<DataItem> get getDataItems =>
      UnmodifiableListView<DataItem>(_listOfItems) ?? [];
  UnmodifiableListView<DataPositionModel> get getDataList =>
      UnmodifiableListView<DataPositionModel>(_listDataItemPosition) ?? [];
  String get getfileLoadingErrorMessage => _fileLoadingErrorMessage;

  set setCalculatingState(CalculatingDataState state) {
    _calcutaringState = state;
    notifyListeners();
  }

  set setFileLoadingState(FileLoadingState state) {
    _fileLoadingState = state;

    notifyListeners();
  }

  set setFileLoadingErrorMessage(String msg) {
    _fileLoadingErrorMessage = msg;
    notifyListeners();
  }

  set setSumPositionsA(double sum) {
    _sumPositionsGroupA = sum;
    notifyListeners();
  }

  set setSumPositionsB(double sum) {
    _sumPositionsGroupB = sum;
    notifyListeners();
  }

  set setMuA(double muA) {
    _muGroupA = muA;
    notifyListeners();
  }

  set setMuB(double muB) {
    _muGroupB = muB;
    notifyListeners();
  }

  set setUA(double uA) {
    _uGroupA = uA;
    notifyListeners();
  }

  set setUB(double uB) {
    _uGroupB = uB;
    notifyListeners();
  }

  set setUMin(double uMin) {
    _uMin = uMin;
    notifyListeners();
  }
  initLists(){
    _listDataItemPosition=[];
    _listOfItems=[];
  }

  loadFile() async {
    _listOfItems = [];
    setFileLoadingState = FileLoadingState.loading;

    try {
      _file = await FilePicker.getFile(fileExtension: 'json');
    } on NoSuchMethodError catch (e) {
      setFileLoadingState = FileLoadingState.error;
      setFileLoadingErrorMessage =
          "An error $e was occuring during loading this file";

      return;
    }
    if (_file == null) {
      setFileLoadingState = FileLoadingState.none;

      return;
    } else if (!p.extension(_file.path).contains('json')) {
      setFileLoadingState = FileLoadingState.error;
      setFileLoadingErrorMessage =
          "This is not a valid JSON file, please try again with a valid one";
    } else {
      Map<dynamic, dynamic> data = json.decode(_file.readAsStringSync());
      if (data.isEmpty) {
        setFileLoadingState = FileLoadingState.error;
        setFileLoadingErrorMessage =
            "This file is empty, Please try with another one";

        return;
      } else if (!data.containsKey('A') && !data.containsKey('B')) {
        setFileLoadingState = FileLoadingState.error;
        setFileLoadingErrorMessage =
            '''Your file syntax is incorrect! use the following one {"A":[value1,value2,value...],"B":[value1,value2,value..]}''';

        return;
      } else {
        if (data['A'].length > 30 || data['B'].length > 30) {
          setFileLoadingState = FileLoadingState.error;
          setFileLoadingErrorMessage =
              "The number of each group items should be less or equal to 30";

          return;
        } else {
          print(data);
          setFileLoadingState = FileLoadingState.done;

          List listA = data['A'];
          for (int i = 0; i < listA?.length; i++) {
            _listOfItems.add(DataItem(Group.groupA, listA[i].toDouble()));
          }
          notifyListeners();
          List listB = data['B'];
          for (int i = 0; i < listB?.length; i++) {
            _listOfItems.add(DataItem(Group.groupB, listB[i].toDouble()));
          }

          _listOfItems.sort((a, b) => a.value.compareTo(b.value));
          notifyListeners();

          await calculatePosData();
        }
      }
    }
  }

  calculatePosData() async {
    setDefaultPositions();
    setCalculatingState = CalculatingDataState.loading;

    if (_listOfItems == null || _listDataItemPosition == null) {
      setCalculatingState = CalculatingDataState.error;
      _calculatingErrorMessage =
          "The list Of data is empty, something went wrong, Please try again";
    } else {
      setCalculatingState = CalculatingDataState.loading;
      notifyListeners();
      for (int i = 0; i < _listDataItemPosition.length; i++) {
        int repTimes =
            repeatsTimes(_listDataItemPosition[i].getDataItem.value, i);
        print('${_listDataItemPosition[i].getDataItem.value}: $repTimes times');
        if (repTimes > 1) {
          double newPs = calculatePosition(i, repTimes);
          for (int j = i; j < i + repTimes; j++) {
            _listDataItemPosition[j].setPosition = newPs;
          }
          i += repTimes - 1;
        }
      }
      logData();
      calculateMuOfAandB();
      setCalculatingState = CalculatingDataState.done;
    }
  }

  calculateMuOfAandB() {
    double sumA = 0;
    double sumB = 0;
    int nbOfItemsB = 0;
    int nbOfItemsA = 0;
    for (DataPositionModel item in _listDataItemPosition) {
      if (item.getDataItem.group == Group.groupA) {
        sumA += item.getPosition;
        nbOfItemsA++;
      } else if (item.getDataItem.group == Group.groupB) {
        sumB += item.getPosition;
        nbOfItemsB++;
      }
    }
    setSumPositionsA = sumA;
    setSumPositionsB = sumB;
    setMuA = (nbOfItemsA * (nbOfItemsA + 1)) / 2;
    setMuB = (nbOfItemsB * (nbOfItemsB + 1)) / 2;
    calculateUOfAandB();
  }

  calculateUOfAandB() {
    setUA = _sumPositionsGroupA - _muGroupA;
    setUB = _sumPositionsGroupB - _muGroupB;
    calculateMuMin();
  }

  calculateMuMin() {
    setUMin = _uGroupA > _uGroupB ? _uGroupB : _uGroupA;
    logData();
  }

  logData() {
    print("***********************************");
    print("number of items : ${_listDataItemPosition.length}");
    print("---------------");
    for (int k = 0; k < _listDataItemPosition.length; k++) {
      print(_listDataItemPosition[k].toString());
    }
    print("***********************************");
    print("Sum Pos group A: $_sumPositionsGroupA");
    print("Mu group A: $_muGroupA");
    print("U group A: $_uGroupA");
    print("***********************************");
    print("Sum Pos group B: $_sumPositionsGroupB");
    print("Mu group B: $_muGroupB");
    print("U group B: $_uGroupB");
    print("***********************************");
    print("U min $_uMin");
  }

  void setDefaultPositions() {
    _listDataItemPosition = [];
    for (DataItem item in _listOfItems) {
      _listDataItemPosition.add(
          DataPositionModel(item, _listOfItems.indexOf(item).toDouble() + 1));
    }
  }

  double calculatePosition(int index, int repTimes) {
    double newPs = 0;
    for (int i = index; i < index + repTimes; i++) {
      newPs += _listDataItemPosition[i].getPosition;
    }
    print(
        '${_listDataItemPosition[index].getDataItem.value} this th pos ${newPs / repTimes}');
    return newPs / repTimes;
  }

  repeatsTimes(double v, int startFrom) {
    int repTimes = 0;
    if (_listDataItemPosition == null) return 0;
    for (int i = startFrom; i < _listDataItemPosition.length; i++) {
      if (_listDataItemPosition[i].getDataItem.value == v) {
        repTimes++;
      }
    }
    return repTimes;
  }
}
