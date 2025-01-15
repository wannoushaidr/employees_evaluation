class PointModel {
  int id;
  int employee_id;
  String description;
  int points_count;
  String? created_at;
  String? updated_at;
  String? deleted_at;

  PointModel(
      {required this.id,
      required this.employee_id,
      required this.description,
      required this.points_count,
      required this.created_at,
      required this.updated_at,
      required this.deleted_at});

  factory PointModel.fromJson(dynamic data) {
    return PointModel(
        id: data['id'],
        employee_id: data['employee_id'],
        description: data['description'],
        points_count: data['points_count'],
        created_at: data['created_at'] ?? '',
        updated_at: data['updated_at'] ?? '',
        deleted_at: data['deleted_at'] ?? '');
  }
}
