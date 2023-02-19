// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'package:mongo_dart/mongo_dart.dart';
import 'package:test_mongodb/db_helper/mongodb.dart';

userModel userModelFromJson(String str) => userModel.fromJson(json.decode(str));

String userModelToJson(userModel data) => json.encode(data.toJson());

class userModel {
  ObjectId? id;
  String? name;
  String? address;
  String? password;

  userModel(
      {required this.id,
      required this.name,
      required this.address,
      required this.password});

  static Future<void> insert(
      String? name, String? address, String? password) async {
    var _id = mongo.ObjectId();

    final data =
        userModel(id: _id, name: name, address: address, password: password);
    var res = await mongodb_connection.insertDB(data);
  }

  static Future<void> delete(userModel user) async {
    await mongodb_connection.deleteUser(user);
  }

  static Future<List<Map<String, dynamic>>> display() async {
    return mongodb_connection.getdata();
  }

  static Future<void> updatedata(
      ObjectId id_, String names, String addresse, String password_) async {
    var UserUp =
        userModel(id: id_, name: names, address: addresse, password: password_);

    await mongodb_connection.UpdateDB(UserUp);
  }

  factory userModel.fromJson(Map<String, dynamic> json) => userModel(
      id: json["id"],
      name: json["name"],
      address: json["address"],
      password: json["password"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "password": password,
      };
}
