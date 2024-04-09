import 'package:flutter/material.dart';
import 'package:flutterinterviewtask/constants.dart';
import 'package:flutterinterviewtask/utils/function_utils.dart';
import 'package:flutterinterviewtask/utils/widget_utils.dart';

class DecorationWidgets {
  static buildCard(BuildContext context, String title, Widget icon,
      Function()? onTap, Color? color) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          border: Border.all(color: Constants.primaryColor),
        ),
        child: Column(
          children: [
            Container(
              child: icon,
              padding: const EdgeInsets.all(12),
            ),
            Container(
              decoration: BoxDecoration(
                  color: color,
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(12),
                      bottomLeft: Radius.circular(12))),
              child: Text(
                title,
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.035,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              padding:
                  EdgeInsets.all(MediaQuery.of(context).size.width * 0.025),
            )
          ],
        ),
      ),
    );
  }

  static buildCategoryTag(bool isSelect, String category) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        // constraints: BoxConstraints(maxWidth: 250),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: isSelect ? Colors.purple[100] : Colors.white,
          border: Border.all(
            color: const Color(0xFF000000),
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          category,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }

  static showProgressDialog() {
    return Container(
        padding: EdgeInsets.all(16),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                semanticsLabel: 'Please wait',
                strokeWidth: 5,
                valueColor:
                    AlwaysStoppedAnimation<Color>(Constants.primaryColor),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Please wait',
                    style: TextStyle(
                        color: Constants.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18)),
              ),
            ]));
  }

  static remainData(BuildContext context, Widget? child1, Widget? child2) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
          child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Container(child: child1),
              ),
              Expanded(
                flex: 1,
                child: Container(child: child2),
              ),
            ],
          ),
          SizedBox(
            height: 3,
          ),
        ],
      )),
    );
  }

  static upcomingEvent(String eventName, Color backgroundColor,
      Widget eventicon, Widget subtitle, List<Widget> children) {
    return ExpansionTile(
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 2),
          borderRadius: BorderRadius.circular(20),
        ),
        controlAffinity: ListTileControlAffinity.trailing,
        childrenPadding: EdgeInsets.fromLTRB(50, 0, 0, 0),
        leading: CircleAvatar(
            radius: 25, backgroundColor: backgroundColor, child: eventicon),
        title: Text(
          eventName,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: subtitle,
        children: children);
  }

  static decorContainer(String containerName, options) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.withOpacity(0.5),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                containerName,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: options,
            ),
          ],
        ),
      ),
    );
  }

  static detailsFields(
      BuildContext context, String columnName, List<Widget> children) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(columnName,
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.045,
                  fontWeight: FontWeight.bold,
                  color: Constants.primaryColor)),
          SizedBox(
            height: 5,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            decoration:
                BoxDecoration(color: Color.fromARGB(255, 241, 241, 241)),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: children,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static drawerTile(BuildContext context, IconData iconData, String title,
      Function()? onTap) {
    return ListTile(
      leading: Icon(
        iconData,
        color: Colors.black,
      ),
      title: Text(
        title,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: MediaQuery.of(context).size.width * 0.035,
            color: Colors.black),
      ),
      onTap: onTap,
    );
  }

  static buildNumberCard(BuildContext context, String key, String value) {
    return Card(
      color: Colors.white,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.075,
        width: MediaQuery.of(context).size.width * 0.37,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              key,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.033),
            ),
            Text(
              value,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width * 0.050),
            )
          ],
        ),
      ),
    );
  }

  static kayValueWidget(BuildContext context, String? key, String? value,
      {bool islink = false}) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: IntrinsicHeight(
          child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  child: Text(
                    key ?? "",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  child: Text(
                    value ?? '',
                    maxLines: 50,
                    style: islink
                        ? TextStyle(
                            fontStyle: FontStyle.italic,
                            decoration: TextDecoration.underline,
                            color: Colors.blue)
                        : TextStyle(),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 3),
          // Divider(
          //   color: Colors.black,
          //   thickness: 1,
          //   height: 5,
          //   indent: 25,
          //   endIndent: 25,
          // ),
        ],
      )),
    );
  }

  static kayTextFieldWidget(BuildContext context, String key,
      TextEditingController? controller, Function()? onPressed) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              key,
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(width: 3),
          Expanded(
            flex: 3,
            child: UtilsWidgets.textFormField(
              'Enter Amount',
              'Eg. 100.50',
              textInputType: TextInputType.phone,
              (p0) {
                if (p0 == null || p0.isEmpty) return 'Please Enter Amount';
              },
              controller,
              inputFormatter: Utils.onlyFloatNumber(),
            ),
          ),
          Expanded(
            flex: 1,
            child: IconButton(
              icon: Icon(Icons.delete),
              onPressed: onPressed,
            ),
          ),
        ],
      ),
    );
  }
}
