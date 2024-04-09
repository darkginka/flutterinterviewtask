import 'package:flutter/material.dart';
import 'package:flutterinterviewtask/constants.dart';
import 'package:flutterinterviewtask/screen/screen1.dart';
import 'package:get/get.dart';

class Screen2 extends StatefulWidget {
  final String name;
  final String price;
  final String img;
  const Screen2(
      {Key? key, required this.name, required this.price, required this.img})
      : super(key: key);

  @override
  State<Screen2> createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    final double halfHeight = MediaQuery.of(context).size.height / 2.5;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          Container(
            height: halfHeight,
            width: screenWidth,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(widget.img),
              ),
              borderRadius: BorderRadius.vertical(
                bottom: Radius.elliptical(screenWidth, 40),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
            alignment: AlignmentDirectional.topStart,
            child: IconButton(
                onPressed: () {
                  Get.to(const Screen1());
                },
                icon: Icon(
                  Icons.chevron_left_outlined,
                  color: Colors.white,
                  size: 50,
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 250.0),
            child: Material(
              elevation: 10,
              borderRadius: BorderRadius.circular(20),
              child: Container(
                height: MediaQuery.of(context).size.height / 1.3,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.name,
                          style: const TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Text(
                              widget.price,
                              style: const TextStyle(
                                fontSize: 27,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              "₹/piece",
                              style: TextStyle(
                                fontSize: 27,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Padding(
                      padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "~ 150 gm / piece",
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Spain",
                          style: const TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Lettuce is an annual plant of the daisy family, Asteraceae. It is most often grown as a leaf vegetable, but sometimes for its stem and seeds. Lettuce is most often used for salads, although it is also seen in other kinds of food, such as soups, sandwiches and wraps; it can also be grilled.",
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Constants.primaryColor,
                              ),
                            ),
                            child: Center(
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isClicked = !isClicked;
                                  });
                                },
                                icon: isClicked
                                    ? Icon(Icons.favorite_border)
                                    : Icon(Icons.favorite),
                                color: Constants.primaryColor,
                              ),
                            ),
                          ),
                          const SizedBox(width: 30),
                          Container(
                            width: 250,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Constants.primaryColor,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Constants.primaryColor,
                              ),
                            ),
                            child: TextButton.icon(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.shopping_cart_outlined,
                                color: Colors.white,
                              ),
                              label: const Text(
                                'ADD TO CART',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
