// ignore_for_file: prefer_typing_uninitialized_variables
import 'dart:developer';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:test_mongodb/db_helper/constant.dart';

// ignore: camel_case_types
class mongodb_connection {
  static var db, userCollection;
  static connect() async {
    db = await Db.create(mongodb_connection_url);
    await db.open();
    inspect(db);
    userCollection = db.collection(user_collection);
  }
}
