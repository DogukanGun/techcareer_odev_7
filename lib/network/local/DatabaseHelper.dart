import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/services.dart';
import 'dart:io';

class DatabaseHelper{
  static final String veritabaniAdi = "todo.sqlite";

  static Future<Database> veritabaniErisim() async {
    String veritabaniYolu = join(await getDatabasesPath(),veritabaniAdi);

    if(await databaseExists(veritabaniYolu)){
      print("Veritabanı zaten var.Kopyalamaya gerek yok.");
    }else{
      ByteData data = await rootBundle.load("veritabani/${veritabaniAdi}");
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes,data.lengthInBytes);
      await File(veritabaniYolu).writeAsBytes(bytes,flush: true);
      print("Veri tabanı kopyalandı");
    }

    return openDatabase(veritabaniYolu);
  }
}