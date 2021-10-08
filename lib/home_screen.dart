import 'dart:convert';

import 'package:firebasepushsend/widget/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String response = "";
  final TextEditingController _serverController = TextEditingController();
  final TextEditingController _deviceController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  final formGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFA611),
      body: Card(
        margin: const EdgeInsets.all(20),
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Form(
            key: formGlobalKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Firebase Push Notification text"),
                AppTextFormField(
                  hintText: 'Server token',
                  controller: _serverController,
                  validator: (result) {
                    if (result.toString().trim().isEmpty) {
                      return "Required";
                    }
                    return null;
                  },
                ),
                AppTextFormField(
                  hintText: 'Device Token',
                  controller: _deviceController,
                  validator: (result) {
                    if (result.toString().trim().isEmpty) {
                      return "Required";
                    }
                    return null;
                  },
                ),
                AppTextFormField(
                  hintText: 'Notification title',
                  controller: _titleController,
                  validator: (result) {
                    if (result.toString().trim().isEmpty) {
                      return "Required";
                    }
                    return null;
                  },
                ),
                AppTextFormField(
                  hintText: 'Notification body',
                  controller: _bodyController,
                  validator: (result) {
                    if (result.toString().trim().isEmpty) {
                      return "Required";
                    }
                    return null;
                  },
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      response = "";
                    });
                    if (formGlobalKey.currentState!.validate()) {
                      fetchData(_titleController.text.toString().trim(),
                          _bodyController.text.toString().trim());
                    }
                  },
                  child: const Text("Send Notification"),
                ),
                if (response != "") Text(response),
              ],
            ),
          ),
        ),
      ),
    );
  }

  fetchData(String title, String body) async {
    var map = {
      "to": _deviceController.text.toString().trim(),
      "collapse_key": "type_a",
      "priority": "high",
      "notification": {
        "body": body,
        "title": title,
        "click_action": "FLUTTER_NOTIFICATION_CLICK",
        "content_available": true,
        "priority": "high"
      },
      "aps": {
        "alert": "Notification with custom payload!",
        "badge": 1,
        "content-available": 1
      },
      "data": {"body": body, "title": title, "action-loc-key": "PLAY"},
    };

    final res = await http.post(
        Uri.parse("https://fcm.googleapis.com/fcm/send"),
        body: json.encode(map),
        headers: {
          "Authorization": "key=${_serverController.text.toString().trim()}",
          "Content-Type": "application/json"
        });
    print(res.body);
    setState(() {
      response = json.decode(res.body).toString();
    });
    if (res.statusCode == 200) {
      var v = json.decode(res.body);
    }
  }
}
