import 'dart:convert';
import 'package:flutterinterviewtask/utils/widget_utils.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameText = TextEditingController(text: '');
  final TextEditingController _costText = TextEditingController(text: '');
  final TextEditingController _discountPriceText =
      TextEditingController(text: '');
  final TextEditingController _moqText = TextEditingController(text: '');
  bool _isLoading = true;
  bool isFind = false;
  String userID = '';
  String action = 'add';
  String id = '';
  String btnName = 'Add Product';
  List productData = [];

  @override
  void initState() {
    productInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UtilsWidgets.buildAppBar(context, btnName),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: UtilsWidgets.textFormField(
                          "Enter product name", "Eg. product", (p0) {
                        if (p0 == null || p0.isEmpty) {
                          return "Please enter product name";
                        }
                      }, _nameText),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: UtilsWidgets.textFormField("moq", "Eg. 100",
                          textInputType: TextInputType.number, (p0) {
                        if (p0 == null || p0.isEmpty) {
                          return "moq";
                        }
                      }, _moqText),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: UtilsWidgets.textFormField(
                          "Enter product price ", "Eg.100",
                          textInputType: TextInputType.number, (p0) {
                        if (p0 == null || p0.isEmpty) {
                          return "Please enter product price";
                        }
                      }, _costText),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: UtilsWidgets.textFormField(
                          "discounted price", "Eg.100",
                          textInputType: TextInputType.number, (p0) {
                        if (p0 == null || p0.isEmpty) {
                          return "discounted price";
                        }
                      }, _discountPriceText),
                    )
                  ],
                ),
                _isLoading
                    ? UtilsWidgets.buildRoundBtn(btnName, () async {
                        if (_formKey.currentState!.validate()) {
                          UtilsWidgets.bottomDialogs(
                              "Please verify that the product code you've entered is not already in use within the system.",
                              'Please Check the info is correct or not',
                              'Cancel',
                              'Submit',
                              context, () {
                            Navigator.of(context).pop();
                          }, () {
                            addeditProduct(action, id);
                            Navigator.of(context).pop();
                          });
                        }
                      })
                    : const CircularProgressIndicator(),
                const SizedBox(height: 10),
                isFind
                    ? UtilsWidgets.drawTable(
                        const [
                            DataColumn(label: Text('Name')),
                            DataColumn(label: Text('MOQ')),
                            DataColumn(label: Text('Price')),
                            DataColumn(label: Text('Discount')),
                            DataColumn(label: Text('Edit')),
                          ],
                        productData
                            .map((e) => DataRow(cells: [
                                  DataCell(Text(e['name'])),
                                  DataCell(Text(e['moq'])),
                                  DataCell(Text(e['price'])),
                                  DataCell(Text(e['discounted_price'])),
                                  DataCell(TextButton.icon(
                                      onPressed: () {
                                        setState(() {
                                          action = 'edit';
                                          id = e['id'];
                                          btnName = 'Update Product';
                                          _nameText.text = e['name'];
                                          _costText.text = e['price'];
                                          _discountPriceText.text =
                                              e['discounted_price'];
                                          _moqText.text = e['moq'];
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.mode_edit,
                                        color: Colors.blue,
                                      ),
                                      label: const Text(
                                        'Edit',
                                        style: TextStyle(
                                            color: Colors.blue,
                                            decoration:
                                                TextDecoration.underline),
                                      ))),
                                ]))
                            .toList(),
                        columnIndex: 0)
                    : Text('NO Product Found'),
                SizedBox(height: 10),
              ],
            )),
      ),
    );
  }

  Future productInfo() async {
    setState(() {
      productData.clear();
    });
    List<dynamic> abc = [];
    final pref = await SharedPreferences.getInstance();
    String token = pref.getString("user_token") ?? "";

    var url = 'https://shareittofriends.com/demo/flutter/productList.php';
    var request = http.MultipartRequest('POST', Uri.parse(url));

    request.fields['user_login_token'] = token;
    // 'c2a2f674c6f6a1d2374da1ebfab69adc';
    var response = await request.send();

    if (response.statusCode == 200) {
      final responseStream = await response.stream.toList();
      var utf8Strings =
          responseStream.map((bytes) => utf8.decode(bytes)).toList();
      String tempString = utf8Strings[0];
      abc = jsonDecode(tempString);
      setState(() {
        isFind = true;
        productData = abc;
      });
    } else {
      final responseStream = await response.stream.toList();
      var utf8Strings =
          responseStream.map((bytes) => utf8.decode(bytes)).toList();
      String tempString = utf8Strings[0];
      Map tempMap = jsonDecode(tempString);
      setState(() {
        isFind = false;
      });
      print('Failed with status code ${response.statusCode}');
      return [];
    }
  }

  Future addeditProduct(String action, String id) async {
    try {
      final pref = await SharedPreferences.getInstance();
      String token = pref.getString("user_token") ?? "";
      String url =
          'https://shareittofriends.com/demo/flutter/${action}Product.php';

      var request = http.MultipartRequest('POST', Uri.parse(url));
      if (action == 'edit') {
        request.fields['id'] = id;
      }
      request.fields['user_login_token'] = token;
      // 'c2a2f674c6f6a1d2374da1ebfab69adc';
      request.fields['name'] = _nameText.text.trim();
      request.fields['moq'] = _moqText.text.trim();
      request.fields['price'] = _costText.text.trim();
      request.fields['discounted_price'] = _discountPriceText.text.trim();

      var response = await request.send();

      if (response.statusCode == 200) {
        final responseStream = await response.stream.toList();
        var utf8Strings =
            responseStream.map((bytes) => utf8.decode(bytes)).toList();
        String tempString = utf8Strings[0];
        final abc = jsonDecode(tempString);
        UtilsWidgets.showGetDialog(context, abc['message'], Colors.green);
        await productInfo();
        onClear();
      } else {
        print('Failed with status code ${response.statusCode}');
      }
    } catch (e) {
      UtilsWidgets.showToastFunc(e.toString());
    }
  }

  void onClear() {
    setState(() {
      btnName = 'Add Product';
      action = 'add';
      id = '';
      _nameText.clear();
      _costText.clear();
      _discountPriceText.clear();
      _moqText.clear();
    });
  }
}
