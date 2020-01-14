import 'package:analyse_donnees_app/models/data_item_model.dart';

class DataPositionModel{
  DataItem _dataItem;
  double _pos;
  double get getPosition =>_pos;
  DataItem get getDataItem => _dataItem;
  set setPosition(double ps){_pos=ps;}
  DataPositionModel(this._dataItem,this._pos);

  @override
  String toString() {
    
    return 'position: $_pos ${_dataItem.toString()}\n';
  }
}
