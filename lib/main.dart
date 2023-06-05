import 'package:aval1_prog2/json_data.dart';
import 'package:aval1_prog2/xml_data.dart';

void main() {
  final xmlFilePath = 'lib/data/sample.xml';

  try {
    XmlData xmlData = XmlData();
    xmlData.load(xmlFilePath);

    print('Has Data: ${xmlData.hasData}');
    print('Data:\n${xmlData.data}');
    print('Fields: ${xmlData.fields}');

    final outputFile = 'lib/data/output.xml';
    xmlData.save(outputFile);
    print('Dados salvos em: $outputFile');
  } catch (e) {
    throw Exception('Um erro ocorreu: $e');
  }

  // Json
  final jsonData = JsonData();
  // Carrega os dados de um arquivo JSON
  jsonData.load('lib/data/sample.json');
  // Verifica se existem dados carregados
  print(jsonData.hasData); //true
  //Obtem a lista de campos
  print(jsonData.fields);

  // Obtem os dados como uma string JSON
  final dataString = jsonData.data;
  print(dataString);

  // Salva os dados em um novo arquivo JSON
  jsonData.save('dados_novos.json');
}
