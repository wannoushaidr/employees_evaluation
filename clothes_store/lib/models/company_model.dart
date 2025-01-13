class CompanyModel {
  int id;
  String name;
  String address;
  int number;
  // int number_of_branch;
  String email;
  String? created_at;
  String? updated_at;
  String? deleted_at;

  CompanyModel(
      {required this.id,
      required this.name,
      required this.number,
      required this.address,
      required this.email,
      // required this.number_of_branch,
      required this.created_at,
      required this.updated_at,
      required this.deleted_at});

  factory CompanyModel.fromJson(dynamic data) {
    return CompanyModel(
        id: data['id'],
        name: data['name'],
        number: data['number'],
        address: data['address'],
        email: data['email'],
        // number_of_branch: data['number_of_branches'],
        created_at: data['created_at'] ?? '',
        updated_at: data['updated_at'] ?? '',
        deleted_at: data['deleted_at'] ?? '');
  }
}
