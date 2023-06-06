part of exchange;

class CsvData extends DelimetedData {
  String _csvFile = '';

  @override
  void load(String fileName) {
    _csvFile = File(fileName).readAsStringSync();
    final csvConverter = CsvToListConverter().convert(_csvFile);
    for (int count = 1; count < csvConverter.length; count++) {
      final value = csvConverter[count];
      if (value.length != fields.length) {
        throw DataException('Erro ao carregar dados do arquivo');
      }
    }
  }

  @override
  void save(String fileName) {
    final fileChanged = File(fileName);
    fileChanged.writeAsStringSync(_csvFile);
    final csvConverter = CsvToListConverter().convert(fileChanged.toString());
    for (int count = 1; count < csvConverter.length; count++) {
      final value = csvConverter[count];
      if (value.length != fields.length) {
        throw DataException('Erro ao salvar os dados do arquivo');
      }
    }
  }

  @override
  void clear() {
    _csvFile = '';
  }

  @override
  bool get hasData => _csvFile.isNotEmpty;

  @override
  String get data {
    if (hasData == false) {
      return '';
    }
    return _csvFile;
  }

  @override
  set data(String dataValue) {
    if (hasData) {
      final line = dataValue.split(delimiter);
      if (line.length != fields.length) {
        throw DataException('Formato Inválido');
      }
    }
    _csvFile = '$_csvFile\n$dataValue';
  }

  @override
  List<String> get fields {
    if (hasData == false) {
      return [];
    }
    final allValues = const CsvToListConverter().convert(_csvFile);
    return allValues.first.map((value) => value.toString()).toList();
  }

  @override
  String get delimiter => const ListToCsvConverter().fieldDelimiter;
}
