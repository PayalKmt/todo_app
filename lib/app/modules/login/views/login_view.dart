import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0XFFF95A3B), Color(0XFFF96713)],
                begin: FractionalOffset.topLeft,
                end: FractionalOffset.bottomRight,
                stops: [0.0, 0.8],
                tileMode: TileMode.mirror),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.network(
                    "https://pluspng.com/img-png/avengers-logo-png-avengers-logo-png-1376.png",
                    width: 90,
                  ),
                  const Text(
                    "To-Do App",
                    style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.italic),
                  ),
                  const SizedBox(height: 10.0,),
                  const Text("EMAIL SIGN-IN",style: TextStyle(fontSize: 22.0,color: Colors.yellow),),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0,right: 10.0,top: 5.0,bottom: 5.0),
                    child: TextFormField(
                      controller: controller.email,
                      keyboardType: TextInputType.emailAddress,
                      validator: (email)=>
                      GetUtils.isEmail(email.toString()) ? null : "* Enter a valid email address",
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Email",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0,right: 10.0,bottom: 5.0,top: 5.0),
                    child: TextFormField(
                      controller: controller.password,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Password",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0))
                          )
                      ),
                    ),
                  ),
                  const SizedBox(height: 23.0,),
                  Container(
                    height: 40.0,
                    width: 90.0,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        color: Colors.lightGreen
                    ),
                    child: GestureDetector(
                      onTap: controller.loginUser,
                      child: const Center(child: Text("Login",style: TextStyle(fontSize: 18.0),)),
                    ),
                  ),
                  const SizedBox(height: 20.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "If you have not registered ",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                      InkWell(
                        child: const Text(
                          'SignUp',
                          style: TextStyle(color: Colors.white),
                        ),
                        onTap: () {
                          Get.offNamed('/registration');
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
