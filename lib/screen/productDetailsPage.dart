import 'dart:convert';
import 'package:flutterinterviewtask/screen/screen1.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutterinterviewtask/utils/widget_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductDetailsPage extends StatefulWidget {
  final product;

  const ProductDetailsPage({super.key, required this.product});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Display product thumbnail
              AspectRatio(
                aspectRatio: 16 / 9,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'assets/images/img1.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Display product title and category tag
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      widget.product.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
              const SizedBox(height: 8),
              const Row(
                children: [
                  Icon(
                    Icons.branding_watermark,
                    color: Colors.black87,
                    size: 18,
                  ),
                  SizedBox(width: 8),
                ],
              ),
              const SizedBox(height: 8),
              // product price
              Row(
                children: [
                  const Text(
                    'Price: ',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (double.parse(widget.product.discounted_price) > 0) ...[
                    const SizedBox(width: 8),
                    Text(
                      '\$${(double.parse(widget.product.price) - (double.parse(widget.product.price) * double.parse(widget.product.discounted_price) / 100)).toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.red[400],
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                  const SizedBox(
                    width: 12,
                  ),
                  // Display original price
                  Text(
                    '\$${widget.product.price}',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.green[700],
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'MOQ: ${widget.product.moq}',
                textAlign: TextAlign.justify,
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 8),
              TextButton.icon(
                  onPressed: () {
                    UtilsWidgets.bottomDialogs(
                        'Are you sure you want to delete?',
                        'Alert',
                        'No',
                        'Yes',
                        context, () {
                      Navigator.of(context).pop();
                    }, () {
                      removeProduct(widget.product.id);
                      Navigator.of(context).pop();
                    });
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  label: const Text(
                    'Delete this Product',
                    style: TextStyle(
                        color: Colors.red,
                        decoration: TextDecoration.underline),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Future removeProduct(String id) async {
    try {
      final pref = await SharedPreferences.getInstance();
      String token = pref.getString("user_token") ?? "";

      String url =
          'https://shareittofriends.com/demo/flutter/deleteProduct.php';
      var request = http.MultipartRequest('POST', Uri.parse(url));

      request.fields['user_login_token'] = token;
      request.fields['id'] = id;

      var response = await request.send();

      if (response.statusCode == 200) {
        final responseStream = await response.stream.toList();
        var utf8Strings =
            responseStream.map((bytes) => utf8.decode(bytes)).toList();
        String tempString = utf8Strings[0];
        final abc = jsonDecode(tempString);
        UtilsWidgets.showGetDialog(context, abc['message'], Colors.green);
        Get.to(const Screen1());
      } else {
        print('Failed with status code ${response.statusCode}');
      }
    } catch (e) {
      UtilsWidgets.showToastFunc(e.toString());
    }
  }
}
