// class DataModel {
//   final String id;
//   String? title;
//   String? desc;
//   String? img;

//   DataModel({this.id, this.title, this.desc, this.img});
  
//   DataModel.fromJson(Map<String, dynamic> json){
//     id = json['id'];
//     title = json['header_title'];
//     desc = json['description'];
//     img = json['mobile_banner_image'];
//   }
  
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['header_title'] = this.title;
//     data['description'] = this.desc;
//     data['mobile_banner_image'] = this.img;
//     return data;
//   }
// }

class DataModel {
  final String id;
  final String desc;
  final String? title;
  final String img;

  const DataModel({
    required this.id,
    required this.desc,
    this.title,
    required this.img,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      id: json['id'],
      desc: json['description'],
      title: json['header_title'],
      img: json['mobile_banner_image'],
    );
  }
}