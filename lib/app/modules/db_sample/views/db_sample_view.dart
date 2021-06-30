import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../utils/index.dart';
import '../../../global_widgets/index.dart';
import '../controllers/db_sample_controller.dart';

class DbSampleView extends GetView<DbSampleController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DbSampleView'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 30.w, horizontal: 50.w),
        child: Column(
          children: [
            Row(
              children: [
                buildIconButton(Icons.add, controller.addOne,
                    color: Colors.green),
              ],
            ),
            Obx(
              () => Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                columnWidths: {
                  0: FlexColumnWidth(2.0),
                  1: FlexColumnWidth(1.0),
                  2: FlexColumnWidth(1.2),
                },
                children: [
                  TableRow(
                    children: [
                      Text(
                        'Name',
                        style: TextStyle(height: 3.0),
                      ),
                      Text('Score'),
                      Text('Action'),
                    ],
                  ),
                  ...buildStudents(),
                ],
              ),
            ),
            SizedBox(height: 30.w),
          ],
        ),
      ),
    );
  }

  List<TableRow> buildStudents() {
    int i = 0;
    return controller.students.map((stu) {
      final index = i;
      i++;

      return TableRow(children: [
        Text(stu.name),
        Text('${stu.score}'),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildIconButton(Icons.update, () => controller.updateOne(index),
                isSmall: true, color: Colors.orange),
            SizedBox(width: 20.w),
            buildIconButton(Icons.delete, () => controller.remove(index),
                isSmall: true, color: Colors.red),
          ],
        )
      ]);
    }).toList();
  }

  Widget buildIconButton(IconData iconData, Function() onTap,
      {Color color = Colors.blue, bool isSmall = false}) {
    return AnimButton(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 20.w),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
          width: isSmall ? 90.w : 120.w,
          height: isSmall ? 90.w : 120.w,
          alignment: Alignment.center,
          child: Icon(
            iconData,
            color: Colors.white,
            size: isSmall ? 50.w : 80.w,
          ),
        ));
  }
}
