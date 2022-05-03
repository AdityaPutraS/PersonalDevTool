import 'dart:convert';

import 'package:objectid/objectid.dart';
import 'package:uuid/uuid.dart';
import 'package:xid/xid.dart';

String parseAndFormatJSON(String text) {
  JsonEncoder encoder = const JsonEncoder.withIndent('    ');
  try {
    final parsedJson = jsonDecode(text);
    return encoder.convert(parsedJson);
  } catch (e) {
    return text;
  }
}

String parseAndFormatInQuery(String text) {
  List<String> splittedText = text.split('\n');
  return splittedText.map((t) => '"$t"').join(',\n');
}

String formatEnvToHelmEnv(String text) {
  List<String> envVarList = text.split('\n');
  List<String> result = [];
  for (var envVar in envVarList) {
    List<String> keyValue = envVar.split('=');
    if (keyValue.length == 2) {
      String key = keyValue[0].trim();
      String value = keyValue[1].trim();
      result.add('$key: "$value"');
    } else {
      result.add(envVar);
    }
  }
  return result.join('\n');
}

String formatHelmEnvToEnv(String text) {
  List<String> helmEnvVarList = text.split('\n');
  List<String> result = [];
  for (var envVar in helmEnvVarList) {
    List<String> keyValue = envVar.split(': "');
    if (keyValue.length == 2) {
      String key = keyValue[0].trim();
      String value = keyValue[1].trim().replaceAll('"', '');
      result.add('$key=$value');
    } else {
      result.add(envVar);
    }
  }
  return result.join('\n');
}

String generateText(String text, int number) {
  String generatedText = '';
  for (var i = 0; i < number; i++) {
    const uuid = Uuid();
    var xid = Xid();
    var mongoid = ObjectId();
    var timestamp = DateTime.now().millisecondsSinceEpoch;
    String formattedText = text
        .replaceAll('\${uuidv4}', uuid.v4())
        .replaceAll('\${xid}', xid.toString())
        .replaceAll('\${mongoid}', mongoid.toString())
        .replaceAll('\${timestamp}', timestamp.toString())
        .replaceAll('\${iter}', i.toString());
    generatedText += formattedText + '\n';
  }
  return generatedText;
}
