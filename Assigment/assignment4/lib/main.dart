import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'providers/activity_provider.dart';
import 'repositories/activity_repository.dart';
import 'services/api_service.dart';
import 'services/storage_service.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ApiService>(create: (_) => ApiService(http.Client())),
        Provider<StorageService>(create: (_) => StorageService()),
        ProxyProvider2<ApiService, StorageService, ActivityRepository>(
          update: (_, apiService, storageService, __) => ActivityRepository(
            apiService: apiService,
            storageService: storageService,
          ),
        ),
        ChangeNotifierProxyProvider<ActivityRepository, ActivityProvider>(
          create: (context) => ActivityProvider(
            ActivityRepository(
              apiService: ApiService(http.Client()),
              storageService: StorageService(),
            ),
          ),
          update: (_, repository, previous) =>
              previous ?? ActivityProvider(repository),
        ),
      ],
      child: MaterialApp(
        title: 'SmartTracker',
        theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
        home: const HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
