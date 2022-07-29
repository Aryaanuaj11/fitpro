import 'dart:developer';
import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

// import 'models/food_entry.dart';

class ApiService {
  static List<String> bodyPartList = [
    "back",
    "cardio",
    "chest",
    "lower arms",
    "lower legs",
    "neck",
    "shoulders",
    "upper arms",
    "upper legs",
    "waist"
  ];
  static List<String> equipmentList = [
    "assisted",
    "band",
    "barbell",
    "body weight",
    "bosu ball",
    "cable",
    "dumbbell",
    "elliptical machine",
    "ez barbell",
    "hammer",
    "kettlebell",
    "leverage machine",
    "medicine ball",
    "olympic barbell",
    "resistance band",
    "roller",
    "rope",
    "skierg machine",
    "sled machine",
    "smith machine",
    "stability ball",
    "stationary bike",
    "stepmill machine",
    "tire",
    "trap bar",
    "upper body ergometer",
    "weighted",
    "wheel roller"
  ];

  Future<Map> getFoodEntry(String query) async {
    try {
      var url = Uri(
          scheme: 'https',
          host: "api.edamam.com",
          path: "/api/food-database/v2/parser",
          queryParameters: {
            "app_id": dotenv.env["APP_ID"],
            "app_key": dotenv.env["APP_KEY"],
            "ingr": query
          });
      var response = await http.get(url);
      if (response.statusCode == 200) {
        dynamic parsed = json.decode(response.body);
        return parsed;
      } else {
        return {};
      }
    } catch (e) {
      log(e.toString());
      return {};
    }
  }

  Future<List<dynamic>> getListBodyParts() async {
    try {
      var url = Uri(
        scheme: 'https',
        host: "exercisedb.p.rapidapi.com",
        path: "/exercises/bodyPartList",
      );
      var response = await http.get(url, headers: {
        "x-rapidapi-host": dotenv.env["X_HOST"] ?? "",
        "x-rapidapi-key": dotenv.env["X_KEY"] ?? ""
      });
      if (response.statusCode == 200) {
        List<dynamic> list = json.decode(response.body);
        return list;
      } else {
        return [];
      }
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  Future<List<dynamic>> getByBodyParts(String query) async {
    try {
      var url = Uri(
          scheme: 'https',
          host: "exercisedb.p.rapidapi.com",
          path: "/exercises/bodyPart/$query");
      var response = await http.get(url, headers: {
        "x-rapidapi-host": dotenv.env["X_HOST"] ?? "",
        "x-rapidapi-key": dotenv.env["X_KEY"] ?? ""
      });
      if (response.statusCode == 200) {
        List<dynamic> parsed = json.decode(response.body);
        return parsed;
      } else {
        return [];
      }
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  Future<List<dynamic>> getByEquipment(String query) async {
    try {
      var url = Uri(
          scheme: 'https',
          host: "exercisedb.p.rapidapi.com",
          path: "/exercises/equipment/$query");
      var response = await http.get(url, headers: {
        "x-rapidapi-host": dotenv.env["X_HOST"] ?? "",
        "x-rapidapi-key": dotenv.env["X_KEY"] ?? ""
      });
      if (response.statusCode == 200) {
        List<dynamic> parsed = json.decode(response.body);
        return parsed;
      } else {
        return [];
      }
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  Future<List<String>> getListEquipment() async {
    try {
      var url = Uri(
          scheme: 'https',
          host: "exercisedb.p.rapidapi.com",
          path: "/exercises/equipmentList");
      var response = await http.get(url, headers: {
        'X-RapidAPI-Key': dotenv.env["X-RapidAPI-KEY"].toString(),
        'X-RapidAPI-Host': dotenv.env["X-RapidAPI-HOST"].toString()
      });
      if (response.statusCode == 200) {
        dynamic parsed = json.decode(response.body);
        return parsed;
      } else {
        return [];
      }
    } catch (e) {
      log(e.toString());
      return [];
    }
  }
}
