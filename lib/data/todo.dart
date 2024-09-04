class Todo{
  int id;
  String title;
  String description;
  bool status;
Todo({
  required this.id,
  required this. title,
  required this .description,
  required this.status,
}) ;
// The toJson method converts the Todo object into a format (a map) that can be easily saved or shared as JSON.
toJson(){
  return {
    'id': id,
    'title':title,
    'description':description,
    'status':status,

  };

}
//The fromJson method takes a map (that looks like JSON) and turns it back into a Todo object, so you can work with it in your app.
fromJson(JsonData){
  return Todo(
  id : JsonData['id'],
  title : JsonData['title'],
  description:JsonData['description'],
  status:JsonData['status'],);
  }
}

