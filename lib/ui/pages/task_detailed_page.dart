import 'package:flutter/material.dart';
import 'package:flutter_note_app/core/controllers/task_controller.dart';
import 'package:flutter_note_app/core/models/tasks_model.dart';
import 'package:flutter_note_app/ui/styles/colors.dart';
import 'package:flutter_note_app/ui/styles/text_styles.dart';
import 'package:flutter_note_app/ui/widgets/icon_button.dart';
import 'package:get/get.dart';

class TaskDetailPage extends StatelessWidget {
  final Task task;
  final _taskController = Get.find<TaskController>();
  TaskDetailPage({@required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(12.0),

        // TODO : Removed
        // child: FloatingActionButton(
        //   backgroundColor: Color(0xFF3B3B3B),
        //   onPressed: () {
        //     Get.to(() => AddTaskPage(
        //           isUpdate: true,
        //           task: task,
        //         ));
        //   },
        //   child: Icon(Icons.edit),
        // ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            _appBar(),
            _body(),
          ],
        ),
      ),
    );
  }

  _appBar() {
    return Container(
      margin: const EdgeInsets.only(top: 24),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MyIconButton(
            onTap: () {
              Get.back();
            },
            icon: Icons.keyboard_arrow_left,
          ),
          MyIconButton(
            onTap: () {
              _deleteTaskFromDB();
              Get.back();
            },
            icon: Icons.delete,
          ),
        ],
      ),
    );
  }

  _body() {
    return Expanded(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(task.date, style: dateTextStyle),
            const SizedBox(
              height: 12,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      task.task,
                      style: bodyTextStyle,
                    ),
                    const SizedBox(
                      height: 40,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _deleteTaskFromDB() async {
    await _taskController.deleteTask(task: task);
  }
}
