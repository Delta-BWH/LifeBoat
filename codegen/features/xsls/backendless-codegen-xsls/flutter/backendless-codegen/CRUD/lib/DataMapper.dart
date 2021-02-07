import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:intl/intl.dart';

List<String> _prepareRaw(List<String> source) {
  return source
    .map( (value) => value == "null" ? "no value" : value)
    .toList();
}

List<String> _prepareFromDate(List<String> source) {
  return source
    .map( (value) => int.tryParse(value) ?? 0)
    .map( (value) => value == 0 
      ? null
      : DateTime.fromMillisecondsSinceEpoch(value))
    .map( (value) => value == null
      ? "no value"
      : DateFormat('yyyy-MM-dd – kk:mm').format(value))
    .toList();
}

class DataMapper {
  static List<String> prepareData(List<String> source, DataTypeEnum type) {
    switch (type) {
      case DataTypeEnum.BOOLEAN:
      case DataTypeEnum.DOUBLE:
      case DataTypeEnum.INT:
      case DataTypeEnum.STRING:
      case DataTypeEnum.STRING_ID:
      case DataTypeEnum.TEXT:
        return _prepareRaw(source);
      case DataTypeEnum.DATETIME:
        return _prepareFromDate(source);
      default:
        return ["Some", "Error"];
    }
  }
}