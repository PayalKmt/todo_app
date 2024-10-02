import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../config.dart';


class LoginController extends GetxController {
  //TODO: Implement LoginController

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  late SharedPreferences prefs;

  loginUser() async {
    try{
      if (email.text.isNotEmpty && password.text.isNotEmpty) {
        var reqBody = {"email": email.text, "password": password.text};

        var response = await http.post(Uri.parse(loginApi),
            headers: {"Content-Type":"application/json"},
            body: jsonEncode(reqBody)
        );

        var jsonResponse = jsonDecode(response.body);

        print(jsonResponse['status']);

        if(jsonResponse['status']){
          var myToken = jsonResponse['token'];
          print(myToken);
          prefs.setString("token", myToken);
          print(prefs.getString("token"));
          Get.snackbar("Successfully", "Logged In");
          Get.toNamed('/dashboard',arguments: myToken);
        }
      }
    }catch(error){
      rethrow;
    }
  }



  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    initSharedPreference();
  }

  void initSharedPreference() async{
    prefs = await SharedPreferences.getInstance();
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
