class Todo {
  int id;
  String title;
  String description;
  bool status;

  Todo({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
  });

  // Convert a Todo object into a Map
 Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'status': status,
      };

  // Create a Todo object from a Map
factory Todo .fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      status: json['status'],
    );
  }
}
