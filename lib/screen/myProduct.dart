import 'package:flutter/material.dart';
import 'package:flutterinterviewtask/model/product_helper.dart';
import 'package:flutterinterviewtask/screen/productDetailsPage.dart';
import 'package:flutterinterviewtask/screen/productShimmer.dart';
import 'package:flutterinterviewtask/utils/widget_utils.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MyProduct extends StatefulWidget {
  const MyProduct({super.key});

  @override
  State<MyProduct> createState() => _MyProductState();
}

class _MyProductState extends State<MyProduct> {
  late Future<List<ProductInfo>> futureProducts;
  bool isFind = false;

  @override
  void initState() {
    futureProducts = productListAPI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UtilsWidgets.buildAppBar(context, "My Products"),
      body: Center(
        child: FutureBuilder<List<ProductInfo>>(
          future: futureProducts,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return const ProductCardShimmer();
                },
              );
            } else if (isFind) {
              return const Text("No data available");
            } else if (snapshot.hasData) {
              final posts = snapshot.data!;
              return ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  final post = posts[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      tileColor: index.isOdd ? Colors.blue[50] : Colors.red[50],
                      onTap: () =>
                          Get.to(ProductDetailsPage(product: posts[index])),
                      leading: Padding(
                        padding:
                            const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                        child: Text(
                          post.name,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                      title: Row(
                        children: [
                          Text(
                            "Price: ",
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            post.price,
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      subtitle: Row(
                        children: [
                          Text(
                            "Discount: ",
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            post.discounted_price,
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      trailing: Text(
                        post.moq,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Text("No data available");
            }
          },
        ),
      ),
    );
  }

  Future<List<ProductInfo>> productListAPI() async {
    List<dynamic> abc = [];
    final pref = await SharedPreferences.getInstance();
    String token = pref.getString("user_token") ?? "";

    var url = 'https://shareittofriends.com/demo/flutter/productList.php';
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields['user_login_token'] = token;
    var response = await request.send();

    if (response.statusCode == 200) {
      final responseStream = await response.stream.toList();
      var utf8Strings =
          responseStream.map((bytes) => utf8.decode(bytes)).toList();
      String tempString = utf8Strings[0];
      abc = jsonDecode(tempString);
      setState(() {
        isFind = false;
      });
      return abc.map((e) => ProductInfo.fromJson(e)).toList();
    } else {
      setState(() {
        isFind = true;
      });
      print('Failed with status code ${response.statusCode}');
      return [];
    }
  }
}
