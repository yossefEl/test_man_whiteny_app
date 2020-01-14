import 'package:analyse_donnees_app/enums/group_enum.dart';

class DataItem{
  Group group;
  double value;
  DataItem(this.group,this.value);
  @override
  String toString() {
    return 'Group: $group and value : $value';
  }
}