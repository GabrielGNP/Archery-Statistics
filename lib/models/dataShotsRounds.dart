import 'package:flutter/cupertino.dart';

class DataShotsRounds{
  late GlobalKey key;
  late int value;
  late bool disabled;
  DataShotsRounds(this.key, this.value, this.disabled);
}

List<List<DataShotsRounds>> dataShotsRounds = [];