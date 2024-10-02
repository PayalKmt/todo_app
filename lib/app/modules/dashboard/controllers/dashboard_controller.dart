import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../config.dart';

class DashboardController extends GetxController {
  //TODO: Implement DashboardController

  final count = 0.obs;
  var token;
  late String email;
  late String userId;
  RxList? items=[].obs;

  // Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  //
  // Future<void> getToken() async {
  //   final SharedPreferences sp = await prefs;
  //   token = sp.getString('token')!;
  // }

  TextEditingController toDoTitle = TextEditingController();
  TextEditingController toDoDesc = TextEditingController();

  void getToken() {
    Map<String, dynamic> jwtDecoderToken = JwtDecoder.decode(token);
    email = jwtDecoderToken['email'];
    userId = jwtDecoderToken['_id'];
    getToDoList(userId);
  }

  addToDoData() async {
    try {
      if (toDoTitle.text.isNotEmpty && toDoDesc.text.isNotEmpty) {
        var reqBody = {
          "userId": userId,
          "title": toDoTitle.text,
          "desc": toDoDesc.text
        };

        var response = await http.post(
          Uri.parse(toDoApi),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(reqBody),
        );

        var jsonResponse = jsonDecode(response.body);
        print(jsonResponse['status']);
        if (jsonResponse['status']) {
          Get.snackbar("successfully", "added data");
          toDoTitle.clear();
          toDoDesc.clear();
          getToDoList(userId);
        }
      }
    } catch (error) {
      rethrow;
    }
  }

  getToDoList(userId) async {
    try {
      var reqBody = {"userId": userId};

      var response = await http.post(
        Uri.parse(getToDoDataApi),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reqBody),
      );

      var jsonResponse = jsonDecode(response.body);

      print(jsonResponse['status']);
      if(jsonResponse['status']){
        items?.value = jsonResponse['success'];
        print(items);
      }

    } catch (error) {
      rethrow;
    }
  }

  deleteItem(id) async {
    try {
      var reqBody = {"id": id};

      var response = await http.post(
        Uri.parse(deleteApi),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reqBody),
      );

      var jsonResponse = jsonDecode(response.body);

      print(jsonResponse['status']);
      if(jsonResponse['status']){
        getToDoList(userId);
      }

    } catch (error) {
      rethrow;
    }
  }



  @override
  void onInit() {
    super.onInit();
    // getToken();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
