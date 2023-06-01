import 'dart:io';
import 'package:aval1_prog2/data.dart';
import 'package:xml/xml.dart';

class XmlData extends Data {
  final xmlFilePath = 'lib/data/sample.xml';
  @override
  void load(){}
  final xmlFile = File(xmlFilePath);
  final xmlString = xmlFile.readAsLinesSync();

  final document = XmlDocument.parse(xmlString);
  final records = document.findAllElements('records');
}
