class TaskModel{
  String id;
  String title;
  String description;
  int date ;
  bool isDone;
  String userId;

  TaskModel({
   this.id="" ,
    required this.title,
    required this.description,
    required this.date,
    this.isDone=false,
    required this.userId,
  });
  TaskModel.fromJson(Map<String, dynamic> json)
      : this(
      id: json['id'],
      date: json['date'],
      description: json['description'],
      isDone: json['isDone'],
      title: json['title'],
      userId: json['userId']
  );

 Map<String,dynamic> toJason(){
  return {
    "id": id,
   "title": title,
    "description": description,
   "date": date,
    "isDone": isDone,
    "userId":userId,
  } ;
 }

}