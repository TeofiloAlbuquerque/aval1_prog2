// import 'package:aval1_prog2/data_exception.dart';
// import 'package:aval1_prog2/delimeted_data.dart';
// import 'exchange.dart';
part of exchange;
class TsvData extends DelimetedData {
  String _tsvFile = '';

  @override
  void load(String fileName) {
    _tsvFile = File(fileName).readAsStringSync();
    final lines = _tsvFile.split('\n');
    final tsvList = lines.map((value) => value.split(delimiter)).toList();
    for (int count = 1; count < tsvList.length; count++) {
      final value = tsvList[count];
      if (value.length != fields.length) {
        throw DataException('Erro ao carregar dados do arquivo');
      }
    }
  }

  @override
  void save(String fileName) {
    final tsvFileChanged = File(fileName);
    tsvFileChanged.writeAsStringSync(_tsvFile);
    final tsvConverter = tsvFileChanged.toString().split('\n');
    final tsvList =
        tsvConverter.map((value) => value.split(delimiter)).toList();
    for (int count = 1; count < tsvList.length; count++) {
      final value = tsvList[count];
      if (value.length != fields.length) {
        throw DataException('Error saving file data');
      }
    }
  }

  @override
  void clear() {
    _tsvFile = '';
  }

  @override
  bool get hasData => _tsvFile.isNotEmpty;

  @override
  String get data {
    if (hasData == false) {
      return '';
    }
    return _tsvFile;
  }

  @override
  set data(String dataValue) {
    if (hasData) {
      final line = dataValue.split(delimiter);
      if (line.length != fields.length) {
        throw DataException('Invalid format');
      }
    }
    _tsvFile = '$_tsvFile\n$dataValue';
  }

  @override
  List<String> get fields {
    if (hasData == false) {
      return [];
    }
    final lines = _tsvFile.split('\n');
    final linesList = lines.map((value) => value.split(delimiter)).toList();
    return linesList.first;
  }

  @override
  String get delimiter => '\t';
}
