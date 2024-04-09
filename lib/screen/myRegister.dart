import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutterinterviewtask/constants.dart';
import 'package:flutterinterviewtask/screen/myLogin.dart';
import 'package:flutterinterviewtask/utils/function_utils.dart';
import 'package:flutterinterviewtask/utils/widget_utils.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

class MyRegister extends StatefulWidget {
  const MyRegister({super.key});

  @override
  State<MyRegister> createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool isObscure = true;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    'assets/images/register.jpg',
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  'REGISTER',
                  style: TextStyle(
                    fontSize: 25,
                    color: Constants.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
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
                          'Enter Your Name',
                          'Name',
                          (p0) {
                            if (p0 == null || p0.isEmpty) {
                              return 'Please Enter Your Name';
                            }
                            return null;
                          },
                          nameController,
                        ),
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
                          emailController,
                          prefixIcon: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Icon(Icons.mail)),
                        ),
                        UtilsWidgets.textFormField(
                          'Enter Your Phone Number',
                          '9876543210',
                          (p0) {
                            if (p0 == null || p0.isEmpty) {
                              return 'Please Enter Your Phone Number';
                            } else if (p0.length > 10 || p0.length < 10) {
                              return 'Please Enter 10 Digit Number';
                            }
                            return null;
                          },
                          phoneController,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              '(+91)',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          textInputType: TextInputType.number,
                          inputFormatter: Utils.onlyIntNumber(),
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
                              : UtilsWidgets.buildRoundBtn('Register', () {
                                  if (_formKey.currentState!.validate()) {
                                    registerAPI();
                                  }
                                }),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: TextButton(
                            child: Row(
                              children: [
                                Text(
                                  'Already have account..?',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  ' click here',
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            onPressed: () {
                              Get.to(MyLogin());
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
    );
  }

  Future<void> registerAPI() async {
    setState(() {
      _isLoading = true;
    });
    var url = 'https://shareittofriends.com/demo/flutter/Register.php';

    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields['name'] = nameController.text;
    request.fields['email'] = emailController.text;
    request.fields['password'] = passwordController.text.trim();
    request.fields['mobile'] = phoneController.text;

    var response = await request.send();
    if (response.statusCode == 200) {
      final responseStream = await response.stream.toList();
      var utf8Strings =
          responseStream.map((bytes) => utf8.decode(bytes)).toList();
      String tempString = utf8Strings[0];
      var abc = jsonDecode(tempString);
      setState(() {
        _isLoading = false;
      });
      UtilsWidgets.showGetDialog(context, abc["message"], Colors.green);
    } else {
      final responseStream = await response.stream.toList();
      var utf8Strings =
          responseStream.map((bytes) => utf8.decode(bytes)).toList();
      String tempString = utf8Strings[0];
      var abc = jsonDecode(tempString);
      setState(() {
        _isLoading = false;
      });
      UtilsWidgets.showGetDialog(context, abc["message"], Colors.red);
      print('Failed with status code ${response.statusCode}');
    }
  }
}
