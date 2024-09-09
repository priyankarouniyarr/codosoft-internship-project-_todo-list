import 'package:flutter/material.dart';
import 'package:todo_list/data/todo.dart';

class TodoView extends StatefulWidget {
  final Todo todo;

  TodoView({
    Key? key,
    required this.todo,
  }) : super(key: key);

  @override
  State<TodoView> createState() => _TodoViewState();
}

class _TodoViewState extends State<TodoView> {
  late TextEditingController titleController;
  late TextEditingController descriptionEditingController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.todo.title);
    descriptionEditingController = TextEditingController(text: widget.todo.description);
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionEditingController.dispose();
    super.dispose();
  }

  void _toggleTodoStatus() {
    setState(() {
      widget.todo.status = !widget.todo.status;
    });
  }

  void _saveChanges() {
    setState(() {
      widget.todo.title = titleController.text;
      widget.todo.description = descriptionEditingController.text;
    });
    Navigator.pop(context, widget.todo);
  }

  void _cancelChanges() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Todo View',
          style: TextStyle(color: Color.fromARGB(255, 18, 15, 207)),
        ),
        elevation: 10,
        centerTitle: true,
        backgroundColor: Colors.amber[600]!.withOpacity(0.8),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  labelText: 'Title',
                  labelStyle: const TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                ),
                controller: titleController,
              ),
              const SizedBox(height: 20),
              TextField(
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  labelText: 'Description',
                  labelStyle: const TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                ),
                maxLines: 4,
                controller: descriptionEditingController,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  GestureDetector(
                    onTap: _toggleTodoStatus,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.amber[600]!.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: Row(
                        children: [
                          Icon(
                            widget.todo.status ? Icons.check_box : Icons.check_box_outline_blank,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            widget.todo.status ?'Task Done' : 'Task Not Done',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: _cancelChanges,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(25),
                ),
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            GestureDetector(
              onTap: _saveChanges,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(25),
                ),
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: const Text(
                  "Save",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
