import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/activity_model.dart';

class StorageService {
  static const String activitiesKey = 'recent_activities';

  Future<void> saveActivities(List<Activity> activities) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> activitiesJson = activities
        .map((activity) => json.encode(activity.toJson()))
        .toList();

    await prefs.setStringList(activitiesKey, activitiesJson);
  }

  Future<List<Activity>> getActivities() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? activitiesJson = prefs.getStringList(activitiesKey);

    if (activitiesJson == null) return [];

    return activitiesJson.map((jsonString) {
      final Map<String, dynamic> data = json.decode(jsonString);
      return Activity.fromJson(data);
    }).toList();
  }

  Future<void> addActivity(Activity activity) async {
    final List<Activity> activities = await getActivities();

    // Keep only recent 5 activities
    activities.insert(0, activity);
    if (activities.length > 5) {
      activities.removeLast();
    }

    await saveActivities(activities);
  }
}
