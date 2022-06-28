
class AddBlogModel {
  String title;
  String content;
  String category;

  AddBlogModel({this.title, this.content, this.category});

  AddBlogModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    content = json['content'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['title'] = this.title;
    data['content'] = this.content;
    data['category'] = this.category;
    return data;
  }
}