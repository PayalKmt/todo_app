import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../config.dart';


class RegistrationController extends GetxController {
  //TODO: Implement RegistrationController

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  registerUser() async{
    try{
      if(emailController.text.isNotEmpty && passwordController.text.isNotEmpty){
        var regBody = {
          "email":emailController.text,
          "password":passwordController.text,
        };

        var response = await http.post(Uri.parse(registration),
            headers: {"Content-Type":"application/json"},
            body: jsonEncode(regBody)
        );

        var jsonResponse = jsonDecode(response.body);
        print(jsonResponse['status']);

        if(jsonResponse['status']){
          Get.toNamed('/login');
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
