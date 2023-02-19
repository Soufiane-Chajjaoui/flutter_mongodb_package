// ignore_for_file: prefer_typing_uninitialized_variables
 import 'package:mongo_dart/mongo_dart.dart';
// ignore: unused_import
import 'package:test_mongodb/controller/user.dart';
import 'package:test_mongodb/db_helper/constant.dart';

import '../modelmongodb.dart';

// ignore: camel_case_types
class mongodb_connection {
  static var db, userCollection;
  static connect() async {
    db = await Db.create(mongodb_connection_url);
    await db.open();
    //inspect(db);
    userCollection = db.collection(user_collection);
  }

  static Future<List<Map<String, dynamic>>> getdata() async {
    return await userCollection.find().toList();
  }

  static Future<void> deleteUser(userModel user) async {
    await userCollection.deleteOne({"id": user.id});
  }

  static Future<void> UpdateDB(userModel data) async {
    var res = await userCollection.findOne(
      {'id': data.id},
    );

    res['name'] = data.name;
    res['address'] = data.address;
    res['password'] = data.password;
    await userCollection.save(res);
  }

  static Future<String> insertDB(userModel data) async {
    try {
      var result = await userCollection.insertOne(data.toJson());
      if (result.isSuccess)
        return "data inserted";
      else
        return "something wrong while inserting data";
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }
}
