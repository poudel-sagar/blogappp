class SuperModel {
  SuperModel({
     this.posts,
  });
    List<Posts> posts;
  
  SuperModel.fromJson(Map<String, dynamic> json){
    posts = List.from(json['posts']).map((e)=>Posts.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['posts'] = posts.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Posts {
  Posts({
     this.author,
     this.category,
     this.comments,
     this.content,
     this.createdAt,
     this.id,
     this.image,
     this.title,
     this.votes,
  });
    Author author;
    String category;
    List<dynamic> comments;
    String content;
    String createdAt;
    int id;
    String image;
    String title;
    List<dynamic> votes;
  //constructor for deserialization to convert 
  //map to object(deserialization = json -> Map ->object)
  Posts.fromJson(Map<String, dynamic> json){
    author = Author.fromJson(json['author']);
    category = json['category'];
    comments = List.castFrom<dynamic, dynamic>(json['comments']);
    content = json['content'];
    createdAt = json['created_at'];
    id = json['id'];
    image = json['image'];
    title = json['title'];
    votes = List.castFrom<dynamic, dynamic>(json['votes']);
  }
  //constructor for serialization to convert 
  //map to json(deserialization = object  -> Map ->json)
  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['author'] = author.toJson();
    _data['category'] = category;
    _data['comments'] = comments;
    _data['content'] = content;
    _data['created_at'] = createdAt;
    _data['id'] = id;
    _data['image'] = image;
    _data['title'] = title;
    _data['votes'] = votes;
    return _data;
  }
}

class Author {
  Author({
     this.createdAt,
     this.email,
     this.id,
     this.isAdmin,
     this.username,
  });
    String createdAt;
    String email;
    int id;
    bool isAdmin;
    String username;
  
  Author.fromJson(Map<String, dynamic> json){
    createdAt = json['created_at'];
    email = json['email'];
    id = json['id'];
    isAdmin = json['is_admin'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['created_at'] = createdAt;
    _data['email'] = email;
    _data['id'] = id;
    _data['is_admin'] = isAdmin;
    _data['username'] = username;
    return _data;
  }
}