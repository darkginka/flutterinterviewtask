import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterinterviewtask/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';

class UtilsWidgets {
  static buildAppBar(BuildContext context, String title,
      {List<Widget>? Widgets, bool backBtn = true}) {
    return AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        toolbarHeight: 60,
        title: Text(
          title,
          maxLines: 3,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: MediaQuery.of(context).size.width * 0.048,
              color: Colors.white),
        ),
        centerTitle: true,
        actions: Widgets,
        automaticallyImplyLeading: backBtn,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
              color: Constants.primaryColor),
        ));
  }

  static ConvexAppBar bottomBar(List<TabItem<dynamic>> items,
      Map<int, dynamic> listOfBadges, Function(int)? onTap) {
    return ConvexAppBar.badge(
      style: TabStyle.reactCircle,
      badgeColor: Colors.black,
      listOfBadges,
      height: 60,
      top: -25,
      curveSize: 100,
      items: items,
      initialActiveIndex: 0,
      onTap: onTap,
      
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.deepPurple, Colors.purple],
      ),
    );
  }

  static textFormField(String? labelText, String hintText,
      String? Function(String?)? validator, TextEditingController? controller,
      {bool isReadOnly = false,
      TextInputType textInputType = TextInputType.text,
      bool obscure = false,
      int maxLine = 1,
      Widget? icon,
      Widget? suffixIcon,
      Widget? prefixIcon,
      Key? key,
      String? Function(String)? onChanged,
      List<TextInputFormatter>? inputFormatter,
      TextInputAction textInputAction = TextInputAction.next}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
      child: Container(
        child: TextFormField(
          onChanged: onChanged,
          style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontSize: 14,
              letterSpacing: 1),
          key: key,
          textInputAction: textInputAction,
          autofocus: false,
          keyboardType: textInputType,
          inputFormatters: inputFormatter,
          controller: controller,
          validator: validator,
          obscureText: obscure,
          maxLines: maxLine,
          readOnly: isReadOnly,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: BorderSide(color: Colors.black, width: 0.0),
            ),
            // contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
            icon: icon,
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            hintText: hintText,
            labelText: labelText,
          ),
        ),
      ),
    );
  }

  static buildRoundBtn(String? btnsend, Function()? onPressed) {
    return SizedBox(
      height: 50,
      width: 190,
      child: ElevatedButton(
          child: Text(
            "$btnsend",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
          style: ElevatedButton.styleFrom(
            elevation: 10,
            backgroundColor: Constants.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
              side: BorderSide(color: Constants.primaryColor),
            ),
          ),
          onPressed: onPressed),
    );
  }

  static showDialogBox(
      BuildContext context,
      String btn1Name,
      String btn2Name,
      Function()? btn1Pressed,
      Function()? btn2Pressed,
      String? title,
      List<Widget> WidgetList) {
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Center(
        child: Text(
          "$title",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      content: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: WidgetList,
        ),
      ),
      actions: [
        TextButton(
          child: Text('$btn1Name'),
          onPressed: btn1Pressed,
        ),
        TextButton(
          child: Text('$btn2Name'),
          onPressed: btn2Pressed,
        ),
      ],
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static showToastFunc(message) {
    return Fluttertoast.showToast(
        msg: message.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Constants.primaryColor,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static showGetDialog(BuildContext context, message, Color? color) {
    return Get.defaultDialog(
        middleText: message,
        contentPadding: EdgeInsets.all(15),
        backgroundColor: Color.fromARGB(255, 227, 235, 239),
        titleStyle: TextStyle(color: color, fontWeight: FontWeight.bold),
        middleTextStyle: TextStyle(color: Colors.black),
        textConfirm: "Ok",
        buttonColor: Constants.primaryColor,
        onConfirm: () {
          Navigator.of(context).pop();
        },
        radius: 20);
  }

  static bottomDialogs(
      String msg,
      String title,
      String btn1name,
      String btn2name,
      BuildContext context,
      Function() on1Pressed,
      Function() on2Pressed,
      {IconData iconData1 = Icons.thumb_up,
      IconData iconData2 = Icons.cancel}) {
    return Dialogs.bottomMaterialDialog(
        msg: msg,
        title: title,
        context: context,
        actions: [
          IconsOutlineButton(
            onPressed: on2Pressed,
            text: btn2name,
            iconData: iconData1,
            color: Constants.primaryColor,
            textStyle: TextStyle(color: Colors.white),
            iconColor: Colors.white,
          ),
          IconsOutlineButton(
            onPressed: on1Pressed,
            text: btn1name,
            iconData: iconData2,
            color: Colors.white70,
            textStyle: TextStyle(color: Constants.primaryColor),
            iconColor: Constants.primaryColor,
          ),
        ]);
  }

  static drawTable(List<DataColumn> columns, List<DataRow> rows,
      {bool sort = true, int columnIndex = 0}) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        child: DataTable(
            sortColumnIndex: columnIndex,
            sortAscending: sort,
            showBottomBorder: true,
            dataTextStyle: const TextStyle(
              color: Colors.black,
            ),
            horizontalMargin: 10,
            headingTextStyle: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
            columnSpacing: 14,
            headingRowColor: MaterialStateColor.resolveWith((states) {
              return Constants.primaryColor;
            }),
            columns: columns,
            rows: rows),
      ),
    );
  }
}
