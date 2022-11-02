import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart'as http;
class Utilities {
  static Future<String> dowloadFileImage(String url, String fileName) async{
    final director = await getApplicationDocumentsDirectory();
    final filePath = '${director.path}/$fileName';
    final respone = await http.get(Uri.parse(url));
    final file = File(filePath);

    await file.writeAsBytes(respone.bodyBytes);
    return filePath;
  }
}