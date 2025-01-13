class EmployeeModel {
  int id;
  String name;
  String description;
  int number;
  String gender;
  String position;
  int? leader_id;
  String image;
  String active;
  int branch_id;
  String created_at;
  String updated_at;

  EmployeeModel(
      {required this.id,
      required this.name,
      required this.number,
      required this.description,
      required this.gender,
      required this.position,
      required this.active,
      required this.created_at,
      required this.updated_at,
      required this.leader_id,
      required this.image,
      required this.branch_id});

  factory EmployeeModel.fromJson(dynamic data) {
    return EmployeeModel(
      id: data['id'],
      name: data['name'],
      number: data['number'],
      description: data['description'],
      gender: data['gender'],
      position: data['position'],
      active: data['active'],
      created_at: data['created_at'],
      updated_at: data['updated_at'],
      leader_id: data['leader_id'],
      image:
          "C:/Users/LENOVO/projects/graduation_project/graduation_project/public/" +
              data['image'],
      branch_id: data['branch_id'],
    );
  }
}
