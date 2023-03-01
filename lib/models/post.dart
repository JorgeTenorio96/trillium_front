class PostList {
  List<Post>? content;
  int? totalElements;
  int? totalPages;
  int? page;

  PostList({this.content, this.totalElements, this.totalPages, this.page});

  PostList.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      content = <Post>[];
      json['content'].forEach((v) {
        content!.add(new Post.fromJson(v));
      });
    }
    totalElements = json['totalElements'];
    totalPages = json['totalPages'];
    page = json['page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.content != null) {
      data['content'] = this.content!.map((v) => v.toJson()).toList();
    }
    data['totalElements'] = this.totalElements;
    data['totalPages'] = this.totalPages;
    data['page'] = this.page;
    return data;
  }
}

class Post {
  int? id;
  String? title;
  String? image;
  List<String>? likes;
  List<Comment>? comments;

  Post({this.id, this.title, this.image, this.likes, this.comments});

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];

    if (json['comentarios'] != null) {
      comments = <Comment>[];
      json['comentarios'].forEach((v) {
        comments!.add(new Comment.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image'] = this.image;
    if (this.comments != null) {
      data['comentarios'] = this.comments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Comment {
  int? idComment;
  String? post;
  String? user;
  String? message;

  Comment({this.idComment, this.post, this.user, this.message});

  Comment.fromJson(Map<String, dynamic> json) {
    idComment = json['id'];
    post = json['post'];
    user = json['user'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.idComment;
    data['post'] = this.post;
    data['user'] = this.user;
    data['message'] = this.message;
    return data;
  }
}
