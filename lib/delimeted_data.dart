import 'package:aval1_prog2/data.dart';

abstract class DelimetedData extends Data{
  //Getter que retorna o caractere separador utilizado para separar os campos
  // de um registro.
  String get delimiter;
}
