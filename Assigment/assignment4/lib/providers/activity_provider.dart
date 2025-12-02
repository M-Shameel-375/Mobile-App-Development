import 'package:flutter/foundation.dart';
import '../models/activity_model.dart';
import '../repositories/activity_repository.dart';

class ActivityProvider with ChangeNotifier {
  final ActivityRepository repository;

  List<Activity> _activities = [];
  bool _isLoading = false;
  String _error = '';

  ActivityProvider(this.repository);

  List<Activity> get activities => _activities;
  bool get isLoading => _isLoading;
  String get error => _error;

  Future<void> loadActivities() async {
    _isLoading = true;
    notifyListeners();

    try {
      _activities = await repository.getActivities();
      _error = '';
    } catch (e) {
      _error = 'Failed to load activities: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addActivity(Activity activity) async {
    _isLoading = true;
    notifyListeners();

    try {
      final Activity newActivity = await repository.createActivity(activity);
      _activities.insert(0, newActivity);
      _error = '';
    } catch (e) {
      _error = 'Failed to add activity: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteActivity(String id) async {
    try {
      await repository.deleteActivity(id);
      _activities.removeWhere((activity) => activity.id == id);
      notifyListeners();
    } catch (e) {
      _error = 'Failed to delete activity: $e';
      notifyListeners();
    }
  }

  List<Activity> searchActivities(String query) {
    if (query.isEmpty) return _activities;

    return _activities.where((activity) {
      return activity.title.toLowerCase().contains(query.toLowerCase()) ||
          activity.description.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }
}
