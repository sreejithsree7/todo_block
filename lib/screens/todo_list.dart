import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:todo_bloc/screens/add_page.dart';
import 'package:http/http.dart' as http;

class TodoListpage extends StatefulWidget {
  const TodoListpage({super.key});

  @override
  State<TodoListpage> createState() => _TodoListpageState();
}

class _TodoListpageState extends State<TodoListpage> {
  List items = [];
  @override
  void initstate() {
    super.initState();
    fetchTodo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Todo List'),
          centerTitle: true,
        ),
        body: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index] as Map;
              return ListTile(
                leading: CircleAvatar(child: Text('${index + 1}')),
                title: Text(item['title']),
                subtitle: Text(item['decreption']),
              );
            }),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: navigateToAddPage, label: Text("Add Todo")));
  }

  void navigateToAddPage() {
    final route = MaterialPageRoute(builder: (context) => AddTodoPage());
    Navigator.push(context, route);
  }

  Future<void> fetchTodo() async {
    final Url = 'https://api.nstack.in/v1/todos?page=1&limit=10';
    final uri = Uri.parse(Url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map;
      final result = json['items'] as List;
      setState(() {
        items = result;
      });
    } else {}
  }
}



// body: ListView.builder(
//             //itemCount: items.length,
//             itemBuilder: (context, index) {
//               final item = items[index] as Map;
//               return ListTile(
//                 leading: Text('${index + 1}'),
//                 title: Text(item['Title']),
//                 subtitle: Text(item['description']),
//               );
//             }),