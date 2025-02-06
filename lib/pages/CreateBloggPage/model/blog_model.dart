class BlogModel {
  final String title;
  final String content;
  final String authorId;
  final String categoryName;
  final String createdAt;
  final String blogId;
  int totalLikes;
  BlogModel({
    required this.title,
    required this.content,
    required this.categoryName,
    required this.authorId,
    required this.totalLikes,
    required this.createdAt,
    required this.blogId,
  });
  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
      title: json["title"],
      content: json["content"],
      authorId: json["author"],
      createdAt: json["created_at"],
      categoryName: json["category_name"],
      blogId: json["id"],
      totalLikes: json["total_likes"],
    );
  }
}

  // "title": "Arna gay",
  //       "content": "ey whats up , whats ip kya bolti public",
  //       "author": "67cb8fd1-db5c-45d9-881b-01a51dc3e71e",
  //       "created_at": "2025-02-04",
  //       "total_likes": 0,
  //       "id": "fc72a9a9-0ec5-435b-a0b7-4e4d8a7880c0",
  //       "category_name": "gay