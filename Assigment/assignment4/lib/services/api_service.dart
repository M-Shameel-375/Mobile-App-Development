import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/activity_model.dart';

class ApiService {
  // For local development
  static const String baseUrl = 'http://localhost:3000/api';

  // For production
  // static const String baseUrl = 'https://your-server.com/api';

  final http.Client client;

  ApiService(this.client);

  // GET - Fetch all activities
  Future<List<Activity>> fetchActivities() async {
    final response = await client.get(Uri.parse('$baseUrl/activities'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => Activity.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load activities');
    }
  }

  // POST - Create new activity
  Future<Activity> createActivity(Activity activity) async {
    final response = await client.post(
      Uri.parse('$baseUrl/activities'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(activity.toJson()),
    );

    if (response.statusCode == 201) {
      return Activity.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create activity');
    }
  }

  // DELETE - Remove activity
  Future<void> deleteActivity(String id) async {
    final response = await client.delete(Uri.parse('$baseUrl/activities/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete activity');
    }
  }
}
