import 'package:flutter/material.dart';
import 'package:todo_list/data/todo.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Todo> todos = [
    Todo(id: 1, title: "Buy Milk", description: "completed", status: false),
    Todo(id: 2, title: "Buy biscuit", description: "completed", status: false),


  ];


  delete(Todo todo){
    return showDialog(context: 
  context, builder: (context)=>AlertDialog(
    title: Text("Delete Todo"),
    content: Text("Are you sure you want to delete this todo"),
    actions: [
      TextButton(onPressed: () {
        setState(() {
          todos.remove(todo);//remove and  elements from the list
          }
          
          );
          Navigator.pop(context);
          }, child: Text("Yes")),

         
          TextButton(onPressed: () {
            Navigator.pop(context);
            }, child: Text("No")),
    ],
  ));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Todo',
            style: TextStyle(color: const Color.fromARGB(255, 15, 207, 191)),
          ),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 39, 57, 160),
        ),
        body: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: todos.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                elevation: 3.0,
                margin: EdgeInsetsDirectional.symmetric(
                    horizontal: 10.0, vertical: 6.0),
                child: GestureDetector(
                    onTap: () {}, child: makelist(todos[index], index)),
              );
            }));
  }

  makelist(Todo todo, index) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      leading: Container(
          padding: EdgeInsets.only(right: 8.0),
          decoration: BoxDecoration(
              border: Border(right: BorderSide(width: 1.0, color: Colors.red))),
          child: CircleAvatar(
            backgroundColor: Colors.blue,
            child: Text("${index + 1}"), // list of todo
          )),
      title: Row(
        children: [
          Text(
            todo.title,
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 10.0,
          ),
          todo.status
              ? Icon(Icons.verified, color: Colors.greenAccent)
              : Container(),
        ],
      ),
      subtitle: Wrap(
        children: [
          Text(
            todo.description,
            overflow: TextOverflow.clip,
            maxLines: 2,
            style: TextStyle(fontSize: 14.0),
          ),
        ],
      ),
       trailing: Row(
        mainAxisSize: MainAxisSize.min, 
        children: [
          GestureDetector(
            onTap: () {
              // EDIT TODO
            },
            child: Icon(Icons.edit, color: Colors.black, size: 30.0),
          ),
          SizedBox(width: 10.0),
          GestureDetector(
            onTap: () {
              delete(todo);
            },
            child: Icon(Icons.delete, color: Colors.black, size: 30.0),
          ),
        ],
      ),
    );
  }
}
