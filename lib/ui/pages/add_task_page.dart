import 'package:flutter/material.dart';
import 'package:flutter_note_app/core/controllers/task_controller.dart';
import 'package:flutter_note_app/core/models/tasks_model.dart';
import 'package:flutter_note_app/ui/pages/task.page.dart';
import 'package:flutter_note_app/ui/styles/colors.dart';
import 'package:flutter_note_app/ui/styles/text_styles.dart';
import 'package:flutter_note_app/ui/widgets/icon_button.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddTaskPage extends StatefulWidget {
  final bool isUpdate;
  final Task task;
  AddTaskPage({this.isUpdate = false, this.task});

  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  TextEditingController _taskTextController = TextEditingController();
  final TaskController _taskController = Get.find<TaskController>();
  DateTime _currentDate = DateTime.now();

  @override
  void initState() {
    if (widget.isUpdate) {
      _taskTextController.text = widget.task.task;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
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
      margin: const EdgeInsets.only(top: 16),
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
              _validateInput();
            },
            txt: widget.isUpdate ? "Update" : "Save",
          ),
        ],
      ),
    );
  }

  _body() {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 12,
          ),
          TextFormField(
            controller: _taskTextController,
            style: bodyTextStyle,
            cursorColor: Colors.white,
            minLines: 3,
            maxLines: 12,
            decoration: InputDecoration(
              hintText: "Type something...",
              hintStyle: bodyTextStyle,
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: bgColor),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: bgColor),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _validateInput() async {
    bool isNotEmpty = _taskTextController.text.isNotEmpty;
    if (isNotEmpty && !widget.isUpdate) {
      _addTaskToDB();
      Get.back();
    } else if (_taskTextController.text != widget.task.task) {
      _updateTask();
      Get.offAll(() => TasksPage());
    } else {
      Get.snackbar(
        widget.isUpdate ? "Not Updated" : "Required*",
        widget.isUpdate ? "Fields are not updated yet." : "All fields are required.",
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
      );
    }
  }

  _addTaskToDB() async {
    await _taskController.addTask(
      task: Task(
        task: _taskTextController.text,
        date: DateFormat.yMMMd().format(_currentDate).toString(),
      ),
    );
  }

  _updateTask() async {
    await _taskController.updateTask(
      task: Task(
        id: widget.task.id,
        task: _taskTextController.text,
        date: DateFormat.yMMMd().format(_currentDate).toString(),
      ),
    );
  }
}
