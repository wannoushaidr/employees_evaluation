class BranchModel {
  int id;
  String name;
  String phone;
  String address;
  String email;
  int company_id;
  String created_at;
  String updated_at;

  BranchModel(
      {required this.id,
      required this.name,
      required this.phone,
      required this.address,
      required this.email,
      required this.company_id,
      required this.created_at,
      required this.updated_at});

  factory BranchModel.fromJson(dynamic data) {
    return BranchModel(
        id: data['id'],
        name: data['name'],
        phone: data['phone'],
        address: data['address'],
        email: data['email'],
        company_id: data['company_id'],
        created_at: data['created_at'],
        updated_at: data['updated_at']);
  }
}
