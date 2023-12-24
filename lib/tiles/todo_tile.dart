import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  final Function(bool?)? onChanged;
  final Function(BuildContext?) deleteFunction;

  const TodoTile(
      {Key? key,
      required this.taskName,
      required this.taskCompleted,
      required this.onChanged,
      required this.deleteFunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete,
              backgroundColor: Colors.red,
              borderRadius: BorderRadius.circular(10),
            ),
          ],
        ),
        child: Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                Checkbox(value: taskCompleted, onChanged: onChanged),
                // task name
                Text(
                  taskName,
                  style: TextStyle(
                      decoration: taskCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none),
                ),
              ],
            )),
      ),
    );
  }
}
