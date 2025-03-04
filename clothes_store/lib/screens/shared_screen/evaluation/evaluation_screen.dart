import 'package:clothes_store/models/branch_model.dart';
import 'package:clothes_store/models/company_model.dart';
import 'package:clothes_store/models/evaluation_model.dart';
import 'package:clothes_store/models/point_model.dart';
import 'package:clothes_store/screens/admin/add_branch_screen.dart';
import 'package:clothes_store/screens/admin/show_all_branches_screen.dart';
import 'package:clothes_store/screens/admin/update_company_screen.dart';
import 'package:clothes_store/services/point_services.dart';
import 'package:flutter/material.dart';


class ShowEvaluationScreen extends StatelessWidget {
  const ShowEvaluationScreen({super.key, required this.evaluations});
  final List<EvaluationModel?>? evaluations;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(' evaluation Data Table'),
        backgroundColor: const Color.fromARGB(255, 39, 95, 193),
        shadowColor: Colors.black,
        elevation: 2,
      ),

      

      body: Container(
        color: const Color.fromARGB(255, 219, 219, 219),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DataTable(
                    headingRowColor: WidgetStateProperty.all(
                        const Color.fromARGB(255, 186, 184, 184)),
                    dataRowColor: WidgetStateProperty.all(
                        const Color.fromARGB(255, 255, 255, 255)),
                    columns: const [
                      DataColumn(
                          label: Text(
                        'ID',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                      DataColumn(
                          label: Text(
                        'employee_id',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                      DataColumn(
                          label: Text(
                        'evaluation',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                      DataColumn(
                          label: Text(
                        'created_at',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                      // DataColumn(
                      //     label: Text(
                      //   'updated_at',
                      //   style: TextStyle(fontWeight: FontWeight.bold),
                      // )),
                    ],
                    rows: evaluations!.map((evaluation) {
                      return DataRow(cells: <DataCell>[
                        DataCell(Text(evaluation!.id.toString())),
                        DataCell(Text(evaluation!.employee_id.toString())),
                        DataCell(Text(evaluation.evaluation.toString())),
                        DataCell(Text(evaluation.created_at.toString())),
                        // DataCell(Text(evaluation.updated_at.toString())),
                        // DataCell(Text(point.description)),
                        
                      ]);
                    }).toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
