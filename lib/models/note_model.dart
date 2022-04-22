class Note {
  String id = '';
  final String title;
  final String body;
  final String time;

  Note(this.id, this.title, this.time, this.body);

  Note.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        title = json["title"],
        body = json["body"],
        time = json["time"];

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'body': body,
        'time': time,
      };
}
