import 'package:do_it/models/quest.dart';
import 'package:flutter/material.dart';

class MyQuest extends StatelessWidget {
  final Quest quest;
  final Function(void) onChanged;

  const MyQuest({
    super.key,
    required this.quest,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        title: Text(
          quest.title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            decoration: quest.isDone ? TextDecoration.lineThrough : null,
            color: quest.isDone
                ? Colors.green
                : Theme.of(context).colorScheme.onSurface,
          ),
        ),
        subtitle: Text(quest.description),
        trailing: Checkbox(
          value: quest.isDone,
          onChanged: (value) {
            onChanged(value);
          },
        ),
      ),
    );
  }
}
