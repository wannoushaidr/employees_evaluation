class EvaluationModel {
   int id;
   int employee_id;
  
   double? evaluation;
   String? created_at;
   String? updated_at;
   String? deleted_at;

   EvaluationModel(
       {required this.id,
       required this.employee_id,
       required this.evaluation,
       required this.created_at,
       required this.updated_at,
       required this.deleted_at});

   factory EvaluationModel.fromJson(dynamic data) {
     return EvaluationModel(
         id: data['id']?? 0,
         employee_id: data['employee_id']?? 0,
         evaluation: data['evaluation']?? 0,
         created_at: data['created_at'] ?? '',
         updated_at: data['updated_at'] ?? '',
         deleted_at: data['deleted_at'] ?? '');
  }
 }

