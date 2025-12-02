import 'package:flutter/material.dart';
import '../models/activity_model.dart';

class ActivityList extends StatelessWidget {
  final List<Activity> activities;
  final Function(Activity)? onActivityTap;
  final Function(Activity)? onActivityDelete;

  const ActivityList({
    super.key,
    required this.activities,
    this.onActivityTap,
    this.onActivityDelete,
  });

  @override
  Widget build(BuildContext context) {
    if (activities.isEmpty) {
      return const Center(child: Text('No activities found'));
    }

    return ListView.builder(
      itemCount: activities.length,
      itemBuilder: (context, index) {
        final activity = activities[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            title: Text(activity.title),
            subtitle: Text(activity.description),
            trailing: onActivityDelete != null
                ? IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => onActivityDelete!(activity),
                  )
                : null,
            onTap: onActivityTap != null
                ? () => onActivityTap!(activity)
                : null,
          ),
        );
      },
    );
  }
}
