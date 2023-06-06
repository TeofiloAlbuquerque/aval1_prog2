part of exchange;

class JsonData extends Data {
  List<Map<String, dynamic>> _data = [];
  List<String> _fields = [];

  @override
  void load(String fileName) {
    try {
      final file = File(fileName);
      final contents = file.readAsStringSync();
      final decodedData = jsonDecode(contents);

      if (decodedData is List) {
        _data = decodedData.cast<Map<String, dynamic>>().toList();
        _updateFields();
      }
    } catch (e) {
      throw DataException('Erro ao carregar dados do arquivo: $e');
    }
  }

  @override
  void save(String fileName) {
    try {
      final file = File(fileName);
      final jsonString = jsonEncode(_data);
      file.writeAsStringSync(jsonString);
    } catch (e) {
      throw DataException('Erro ao salvar dados no arquivo: $e');
    }
  }

  @override
  void clear() {
    _data = [];
    _fields = [];
  }

  @override
  bool get hasData => _data.isNotEmpty;

  @override
  String get data {
    if (_data.isEmpty) {
      return '';
    }
    return jsonEncode(_data);
  }

  @override
  set data(String dataValue) {
    try {
      final decodedData = jsonDecode(dataValue);
      if (decodedData.isEmpty) {
        _data = [];
        _fields = [];
      } else {
        if (decodedData is List) {
          _data = decodedData.cast<Map<String, dynamic>>().toList();
          _updateFields();
        } else {
          throw DataException('Formato de dados inválido');
        }
      }
    } catch (e) {
      throw DataException('Erro ao definir dados: $e');
    }
  }

  @override
  List<String> get fields => _fields;

  void _updateFields() {
    if (_data.isNotEmpty) {
      final allFields = <String>{};
      for (final dataMap in _data) {
        allFields.addAll(dataMap.keys);
      }
      _fields = allFields.toList();
    } else {
      _fields = [];
    }
  }
}
