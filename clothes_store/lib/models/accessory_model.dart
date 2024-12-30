class AccessoryModel {
  int id;
  String type;
  String image;
  int branch_id;
  String created_at;
  String updated_at;
  String? deleted_at;

  AccessoryModel(
      {required this.id,
      required this.type,
      required this.image,
      required this.branch_id,
      required this.created_at,
      required this.updated_at,
      required this.deleted_at});

  factory AccessoryModel.fromJson(dynamic data) {
    return AccessoryModel(
      id: data['id'],
      type: data['type'],
      branch_id: data['branch_id'],
      created_at: data['created_at'],
      updated_at: data['updated_at'],
      deleted_at: data['deleted_at'],
      image:
          "C:/Users/LENOVO/projects/graduation_project/graduation_project/public/" +
              data['image'],
    );
  }
}
