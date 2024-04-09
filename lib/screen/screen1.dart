import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutterinterviewtask/constants.dart';
import 'package:flutterinterviewtask/screen/add_product.dart';
import 'package:flutterinterviewtask/screen/myProduct.dart';
import 'package:flutterinterviewtask/screen/screen2.dart';
import 'package:flutterinterviewtask/utils/decoration_utils.dart';
import 'package:flutterinterviewtask/utils/widget_utils.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Screen1 extends StatefulWidget {
  const Screen1({Key? key}) : super(key: key);

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _searchText = TextEditingController(text: '');
  List productName = ['Boston Lettuce', 'Purple Cauliflower', 'Savoy Cabbage'];
  List productPrice = ["01.10 ", "01.85 ", "01.45 "];
  List<bool> isClicked = [false, false, false];

  String token = '';
  Map<int, dynamic> bottomMap = {};
  int selectedPage = 0;
  List<Widget> _pageNo = [];

  @override
  void initState() {
    getData();
    _pageNo = [Screen1(), MyProduct(), AddProduct()];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double halfHeight = MediaQuery.of(context).size.height / 2.5;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        bottomNavigationBar: UtilsWidgets.bottomBar([
          TabItem(
            title: 'Home',
            icon: Icons.home,
          ),
          TabItem(title: 'Products', icon: Icons.live_tv),
          TabItem(title: 'Add Product', icon: Icons.add),
        ], bottomMap, (int i) {
          setState(() {
            selectedPage = i;
          });
        }),
        body: selectedPage != 0
            ? _pageNo[selectedPage]
            : Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      height: 180, // Set the height as per your requirement
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage('assets/images/unnamed.png'),
                        ),
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.elliptical(screenWidth, 40),
                        ),
                      ),
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(top: 40, left: 16),
                          child: Text(
                            'Vegetables',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 32,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    UtilsWidgets.textFormField("Search", "Eg. apple", (p0) {
                      if (p0 == null || p0.isEmpty) {
                        return "Please enter product name";
                      }
                    }, _searchText, prefixIcon: Icon(Icons.search)),
                    Wrap(
                      clipBehavior: Clip.antiAlias,
                      children: [
                        DecorationWidgets.buildCategoryTag(
                            true, 'Cabbage and lettuse(14)'),
                        DecorationWidgets.buildCategoryTag(false, 'Pappers(7)'),
                        DecorationWidgets.buildCategoryTag(
                            false, 'Cucumber and tomato(10)'),
                        DecorationWidgets.buildCategoryTag(
                            false, 'Onians and garlic(8)'),
                        DecorationWidgets.buildCategoryTag(
                            false, 'Potatoes and carrot(9)'),
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Get.to(Screen2(
                                  name: productName[index],
                                  price: productPrice[index],
                                  img: 'assets/images/img${index + 1}.png'));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  Container(
                                    width: 150,
                                    height: 120,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: AssetImage(
                                                'assets/images/img${index + 1}.png'))),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            height: 20,
                                            child: Text(
                                              productName[index],
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Container(
                                            width: double.infinity,
                                            height: 32,
                                            child: Row(
                                              children: [
                                                Text(
                                                  productPrice[index],
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  "₹/piece",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.grey,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    width: 40,
                                                    height: 25,
                                                    child: IconButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          isClicked[index] =
                                                              !isClicked[index];
                                                        });
                                                      },
                                                      icon: isClicked[index]
                                                          ? Icon(Icons
                                                              .favorite_border)
                                                          : Icon(
                                                              Icons.favorite),
                                                      color: Constants
                                                          .primaryColor,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 4),
                                                  Container(
                                                    width: 40,
                                                    height: 25,
                                                    child: IconButton(
                                                      onPressed: () {},
                                                      icon: Icon(Icons
                                                          .shopping_cart_outlined),
                                                      color: Constants
                                                          .primaryColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ));
  }

  getData() async {
    final pref = await SharedPreferences.getInstance();
    token = pref.getString("user_token") ?? "";
    print(token);
  }
}
