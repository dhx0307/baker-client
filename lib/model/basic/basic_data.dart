import 'dart:convert';

abstract class IacpPojo {
  Map<String, dynamic> toJson();

  @override
  String toString() {
    return  json.encode(toJson());
  }
}