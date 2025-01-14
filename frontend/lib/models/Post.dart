class Post {
  String id;
  String title;
  String content;
  String tags;
  String user;
  String createdAt;

  Post(
      {required this.id,
      required this.title,
      required this.content,
      required this.tags,
      required this.user,
      required this.createdAt});

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json['_id'],
        title: json['title'],
        content: json['content'],
        tags: json['tags'],
        user: json['user'],
        createdAt: json['createdAt'],
      );
}
