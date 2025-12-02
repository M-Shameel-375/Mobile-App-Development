import '../models/activity_model.dart';
import '../services/api_service.dart';
import '../services/storage_service.dart';

class ActivityRepository {
  final ApiService apiService;
  final StorageService storageService;

  ActivityRepository({required this.apiService, required this.storageService});

  Future<List<Activity>> getActivities() async {
    try {
      // Try to fetch from API first
      final List<Activity> activities = await apiService.fetchActivities();

      // Update local storage with fresh data
      await storageService.saveActivities(activities.take(5).toList());

      return activities;
    } catch (e) {
      // Fallback to local storage if API fails
      print('API failed, using local storage: $e');
      return await storageService.getActivities();
    }
  }

  Future<Activity> createActivity(Activity activity) async {
    try {
      // Save to local storage immediately
      await storageService.addActivity(activity);

      // Try to sync with API
      final Activity syncedActivity = await apiService.createActivity(activity);

      return syncedActivity.copyWith(isSynced: true);
    } catch (e) {
      // Return activity with sync failure status
      return activity.copyWith(isSynced: false);
    }
  }

  Future<void> deleteActivity(String id) async {
    try {
      await apiService.deleteActivity(id);

      // Also remove from local storage
      final List<Activity> activities = await storageService.getActivities();
      activities.removeWhere((activity) => activity.id == id);
      await storageService.saveActivities(activities);
    } catch (e) {
      throw Exception('Failed to delete activity: $e');
    }
  }
}
