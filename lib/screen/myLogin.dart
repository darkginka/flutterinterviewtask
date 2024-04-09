import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutterinterviewtask/constants.dart';
import 'package:flutterinterviewtask/screen/myRegister.dart';
import 'package:flutterinterviewtask/model/product_helper.dart';
import 'package:flutterinterviewtask/screen/screen1.dart';
import 'package:flutterinterviewtask/utils/function_utils.dart';
import 'package:flutterinterviewtask/utils/widget_utils.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({super.key});

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  late Future<List<ProductInfo>> futureProducts;
  final _formKey = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isObscure = true;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (canPop) {
        UtilsWidgets.showDialogBox(
            context,
            'Yes',
            'No',
            () => exit(0),
            () => Navigator.of(context).pop(false),
            'Are you sure?',
            [Text('Do you want to exit an App')]);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
              child: Column(
                children: [
                  Container(
                    height: 200,
                    child: Image.asset(
                      'assets/images/login.png',
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'LOGIN',
                    style: TextStyle(
                      fontSize: 25,
                      color: Constants.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Add your phone number and password. we'll verify you so we know you're real",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 15),
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          UtilsWidgets.textFormField(
                            'Enter Your Email',
                            'test@mail.com',
                            (p0) {
                              if (p0 == null || p0.isEmpty) {
                                return 'Please enter your email';
                              } else if (Utils.validateEmail(p0)) {
                                return 'Please enter valid email';
                              }
                              return null;
                            },
                            phoneController,
                            prefixIcon: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Icon(Icons.mail)),
                          ),
                          UtilsWidgets.textFormField(
                            'Enter Your Password',
                            'password',
                            (p0) {
                              if (p0 == null || p0.isEmpty) {
                                return 'Please Enter Your Password';
                              }
                              return null;
                            },
                            passwordController,
                            obscure: isObscure,
                            suffixIcon: IconButton(
                              icon: Icon(
                                isObscure
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Theme.of(context).primaryColor,
                              ),
                              onPressed: () {
                                setState(() {
                                  isObscure = !isObscure;
                                });
                              },
                            ),
                          ),
                          SizedBox(height: 10),
                          SizedBox(
                            width: 200,
                            child: _isLoading
                                ? Center(child: CircularProgressIndicator())
                                : UtilsWidgets.buildRoundBtn('Login', () {
                                    if (_formKey.currentState!.validate()) {
                                      loginAPI();
                                    }
                                  }),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: TextButton(
                              child: Text(
                                'Register here',
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {
                                Get.to(MyRegister());
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> loginAPI() async {
    setState(() {
      _isLoading = true;
    });
    final pref = await SharedPreferences.getInstance();

    var url = 'https://shareittofriends.com/demo/flutter/Login.php';

    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields['email'] = phoneController.text.trim();
    request.fields['password'] = passwordController.text.trim();

    var response = await request.send();

    if (response.statusCode == 200) {
      final responseStream = await response.stream.toList();
      var utf8Strings =
          responseStream.map((bytes) => utf8.decode(bytes)).toList();
      String tempString = utf8Strings[0];
      var abc = jsonDecode(tempString);
      // UtilsWidgets.showGetDialog(context, abc["message"], Colors.green);
      pref.setString('user_token', abc["data"]["user_token"]);
      pref.setString('id', abc["data"]["id"]);
      pref.setString('name', abc["data"]["name"]);
      pref.setString('mobile', abc["data"]["mobile"]);
      pref.setString('email', abc["data"]["email"]);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Screen1(),
        ),
      );
      setState(() {
        _isLoading = false;
      });
    } else {
      final responseStream = await response.stream.toList();
      var utf8Strings =
          responseStream.map((bytes) => utf8.decode(bytes)).toList();
      String tempString = utf8Strings[0];
      var abc = jsonDecode(tempString);
      UtilsWidgets.showGetDialog(context, abc["message"], Colors.red);
      setState(() {
        _isLoading = false;
      });
      // print('Failed with status code ${response.statusCode}');
    }
  }
}
