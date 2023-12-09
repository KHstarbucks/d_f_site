class Post{
  String Id;
  String title;
  String content;
  String author;
  int likes;
  int dislike;
  int views;
  DateTime createdAt;

  Post({required this.Id, required this.title, required this.content, required this.author, required this.likes, required this.dislike ,required this.views, required this.createdAt});
}

class Comment{
  String postId;
  String text;
  String username;
  DateTime commentAt;

  Comment({required this.postId, required this.text, required this.username, required this.commentAt});
}