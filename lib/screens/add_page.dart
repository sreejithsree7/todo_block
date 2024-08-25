import 'dart:convert';
import 'dart:ffi';
//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({super.key});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  TextEditingController Titlecontroller = TextEditingController();
  TextEditingController Descreptioncontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Todo"),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            controller: Titlecontroller,
            decoration: InputDecoration(hintText: 'Title'),
          ),
          TextField(
            controller: Descreptioncontroller,
            decoration: InputDecoration(labelText: 'Description'),
            keyboardType: TextInputType.multiline,
            minLines: 5,
            maxLines: 8,
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(onPressed: submitData, child: Text('submit'))
        ],
      ),
    );
  }

  Future<void> submitData() async {
    final title = Titlecontroller.text;
    final description = Descreptioncontroller.text;
    final body = {
      {"title": title, "description": description, "is_completed": false}
    };
    final url = 'https://api.nstack.in/v1/todos';
    final uri = Uri.parse(url);
    final response = await http.post(uri,
        body: jsonEncode(body), headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 201) {
      Titlecontroller.text = '';
      Descreptioncontroller.text = '';
      ShowSuccessMessage('Create Success');
    } else {
      ShowErrorMessage('Creation Failed');
    }
  }

  void ShowSuccessMessage(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void ShowErrorMessage(String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
