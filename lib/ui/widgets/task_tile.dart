import 'package:flutter/material.dart';
import 'package:flutter_note_app/core/models/tasks_model.dart';
import 'package:flutter_note_app/ui/pages/task_detailed_page.dart';
import 'package:flutter_note_app/ui/styles/colors.dart';
import 'package:flutter_note_app/ui/styles/text_styles.dart';
import 'package:get/get.dart';

import 'note_tile.dart';

// enum TileType {
//   Square,
//   VerRect,
//   HorRect,
// }

class TaskTile extends StatelessWidget {
  final Task task;
  final TileType tileType;
  TaskTile({
    @required this.task,
    @required this.tileType,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
          () => TaskDetailPage(task: task),
          transition: Transition.leftToRight,
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: tileColors[task.id % 7],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: tileType == TileType.HorRect ? const EdgeInsets.only(right: 100) : null,
              child: Text(
                task.task,
                maxLines: _getMaxLines(tileType),
                style: noteTitleTextStyle.copyWith(
                  fontSize: _getTxtSize(tileType),
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(task.date, style: dateTextStyle.copyWith(color: Colors.black.withOpacity(0.7))),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _getTxtSize(TileType tileType) {
    switch (tileType) {
      case TileType.Square:
        return 21.0;
      case TileType.VerRect:
        return 24.0;
      case TileType.HorRect:
        return 29.0;
    }
  }

  _getMaxLines(TileType tileType) {
    switch (tileType) {
      case TileType.Square:
        return 4;
      case TileType.VerRect:
        return 8;
      case TileType.HorRect:
        return 3;
    }
  }
}
