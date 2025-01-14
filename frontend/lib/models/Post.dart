class Post {
  String id;
  String title;
  String content;
  String tags;
  String user;

  Post(
      {required this.id,
      required this.title,
      required this.content,
      required this.tags,
      required this.user});

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json['_id'],
        title: json['title'],
        content: json['content'],
        tags: json['tags'],
        user: json['user'],
      );
}
