abstract class Data {
  // Carrega o arquivo texto “fileName” para a memória.
  void load(String fileName) {}
  //Grava os dados armazenados em memória no arquivo texto “fileName”.
  void save(String fileName) {}
  // Limpa os dados armazenados na memória interna do objeto.
  void clear() {}
  // Getter que indica se existem dados carregados na memória do objeto.
  bool get hasData;

  // Getter/setter que retorna/armazena dados na memória do objeto
  String get data;
  set data (String dataValue);
  // Getter que retorna os nomes dos campos de um registro.
  List<String> get fields;
}
