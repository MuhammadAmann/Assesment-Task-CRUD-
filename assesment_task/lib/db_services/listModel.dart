class listModel {
  final int? id;
  final String title;
  final String subtitle;

  listModel({this.id, required this.title, required this.subtitle});

  listModel.fromMap(Map<String, dynamic> model)
      : id = model['id'],
        title = model['title'],
        subtitle = model['subtitle'];

  Map<String, Object?> toMap() {
    return {
      'id' : id,
      'title' : title,
      'subtitle' : subtitle,
    };
  }
}
