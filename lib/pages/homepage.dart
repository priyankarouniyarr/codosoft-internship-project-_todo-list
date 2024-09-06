import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/data/todo.dart';
import 'package:todo_list/pages/viewingpage.dart';

class Homepage extends StatefulWidget {
  
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  SharedPreferences? prefs;
  List<Todo> todos = [
   
  ];

  @override
  void initState() {
    super.initState();
    loadTodos(); // Loading todos from SharedPreferences when the app starts
  }

  // Load todos from SharedPreferences
  Future<void> loadTodos() async {
    prefs = await SharedPreferences.getInstance();
    String? storedTodos = prefs?.getString('todos');
    if (storedTodos != null) {
      List<dynamic> decodedTodos = jsonDecode(storedTodos);
      setState(() {
        todos = decodedTodos.map((item) => Todo.fromJson(item)).toList();
      });
    }
  }

  // Save todos to SharedPreferences
  void saveTodos() {
    List<Map<String, dynamic>> todoList = todos.map((e) => e.toJson()).toList();
    prefs?.setString('todos', jsonEncode(todoList));
  }

  // Add todo
  Future<void> addTodo() async {
    int id = Random().nextInt(30);
    Todo newTodo = Todo(id: id, title: '', description: '', status: false);
    Todo? returnTodo = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TodoView(todo: newTodo)),
    );

    if (returnTodo != null) {
      setState(() {
        todos.add(returnTodo);
      });
      saveTodos();
    }
  }

  // Delete todo
  void delete(Todo todo) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Todo"),
        content: const Text("Are you sure you want to delete this todo?"),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                todos.remove(todo);
                saveTodos(); // Update SharedPreferences after deleting
              });
              Navigator.pop(context);
            },
            child: const Text("Yes"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("No"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Todo',
          style: TextStyle(color: Color.fromARGB(255, 15, 207, 191)),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 39, 57, 160),
      ),
      body: ListView.builder(
  
        itemCount: todos.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            elevation: 3.0,
            margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            child: buildListTile(todos[index], index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, size: 20, color: Colors.white),
        onPressed: addTodo,
        backgroundColor: Colors.blue,
      ),
    );
  }

  Widget buildListTile(Todo todo, int index) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      leading: Container(
        padding: const EdgeInsets.only(right: 8.0),
        decoration: const BoxDecoration(
          border: Border(right: BorderSide(width: 1.0, color: Colors.red)),
        ),
        child: CircleAvatar(
          backgroundColor: Colors.blue,
          child: Text("${index + 1}"), // List of todo
        ),
      ),
      title: Row(
        children: [
          Text(
            todo.title,
            style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 10.0),
          todo.status ? const Icon(Icons.verified, color: Colors.greenAccent) : Container(),
        ],
      ),
      subtitle: Wrap(
        children: [
          Text(
            todo.description,
            overflow: TextOverflow.clip,
            maxLines: 2,
            style: const TextStyle(fontSize: 14.0),
          ),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () async {
              Todo? updatedTodo = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TodoView(todo: todo)),
              );
              if (updatedTodo != null) {
                setState(() {
                  int index = todos.indexOf(todo);
                  todos[index] = updatedTodo;
                });
                saveTodos(); // Save updated todo
              }
            },
            child: const Icon(Icons.edit, color: Colors.black, size: 30.0),
          ),
          const SizedBox(width: 10.0),
          GestureDetector(
            onTap: () {
              delete(todo);
            },
            child: const Icon(Icons.delete, color: Colors.black, size: 30.0),
          ),
        ],
      ),
    );
  }
}
 
