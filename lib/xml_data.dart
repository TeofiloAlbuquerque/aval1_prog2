part of exchange;
class XmlData extends Data {
  List<String> _data = [];
  List<String> _fields = [];

  @override
  void load(String fileName) {
    try {
      final xmlFile = File(fileName);
      final xmlString = xmlFile.readAsStringSync();

      final document = XmlDocument.parse(xmlString);
      final records = document.findAllElements('record');

      if (records.isNotEmpty) {
        final firstRecord = records.first;
        final attributes = firstRecord.attributes;
        _fields = attributes.map((attr) => attr.name.toString()).toList();
      }
      _data = records.map((record) {
        return _fields.map((field) {
          final value = record.getAttribute(field);
          if (value == null) {
            throw DataException("Nome do campo ausente nos dados $field");
          }
          return value;
        }).join(', ');
      }).toList();
    } catch (e) {
      throw DataException('Falha ao carregar o arquivo XML: $e');
    }
  }

  @override
  void save(String fileName) {
    try {
      final document = _buildXmlDocument();
      final xmlString = document.toXmlString(pretty: true);
      final xmlFile = File(fileName);
      xmlFile.writeAsStringSync(xmlString);
    } catch (e) {
      throw DataException('Falha ao salvar dados no arquivo XML: $e');
    }
  }

  @override
  void clear() {
    try {
      _data.clear();
      _fields.clear();
    } catch (e) {
      throw DataException('Falha ao limpar os dados: $e');
    }
  }

  @override
  bool get hasData => _data.isNotEmpty;

  @override
  String get data => _buildXmlDocument().toXmlString(pretty: true);

  @override
  set data(String dataValue) {
    try {
      _data.clear();
      if (dataValue.isNotEmpty) {
        final records = dataValue.split('\n');
        for (var record in records) {
          final values = record.split(', ');
          if (values.length != _fields.length) {
            throw DataException('Formato de dados inválido');
          }
          _data.add(record);
        }
      }
    } catch (e) {
      throw DataException('Falha ao definir os dados: $e');
    }
  }

  @override
  List<String> get fields => List.from(_fields);

  XmlDocument _buildXmlDocument() {
    final builder = XmlBuilder();
    builder.processing('xml', 'version"1.0" encoding="UTF-8"');
    builder.element('data', nest: () {
      for (var recordData in _data) {
        final values = recordData.split(', ');
        builder.element('record', nest: () {
          for (var i = 0; i < _fields.length; i++) {
            final fieldName = _fields[i];
            final fieldValue = values[i];
            builder.attribute(fieldName, fieldValue);
          }
        });
      }
    });
    return builder.buildDocument();
  }
}
