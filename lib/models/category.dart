class CategoryModel {
  String? id;
  String? name;
  String? emoji;
  String? uid;

  CategoryModel({required this.name, required this.emoji, required this.uid});

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": emoji,
    "uid": uid,
  };

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    emoji = json['emoji'];
    uid = json['uid'];
  }

}


  