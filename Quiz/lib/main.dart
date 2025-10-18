import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(ProfileApp());
}

class ProfileApp extends StatelessWidget {
  const ProfileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile App',
      debugShowCheckedModeBanner: false, // Add this line to remove debug banner
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Variables for user data and form handling
  String username = 'Muhammad Shameel';
  String email = 'mshameel946@gmail.com.com';
  String bio = 'Flutter developer passionate about creating beautiful and functional mobile applications.';
  final TextEditingController _usernameController = TextEditingController();
  bool showValidationError = false;

  @override
  void initState() {
    super.initState();
    _usernameController.text = username;
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  // Function to handle edit button press
  void _handleEdit() {
    if (_usernameController.text.isEmpty) {
      setState(() {
        showValidationError = true;
      });
    } else {
      setState(() {
        username = _usernameController.text;
        showValidationError = false;
      });
      // Show success message (in real app, you might use a SnackBar)
      if (kDebugMode) {
        print('Username updated to: $username');
      }
    }
  }

  // Function to handle cancel button press
  void _handleCancel() {
    setState(() {
      _usernameController.text = username;
      showValidationError = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Detect screen orientation using MediaQuery
    final orientation = MediaQuery.of(context).orientation;
    final orientationText = orientation == Orientation.portrait ? 'Portrait' : 'Landscape';

    return Scaffold(
      // AppBar with title
      appBar: AppBar(
        title: const Text('Profile Screen'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),

      // SafeArea to avoid system UI areas
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Profile Image Section with LOCAL image
              _buildProfileImage(),

              const SizedBox(height: 20),

              // User Info with RichText
              _buildUserInfo(),

              const SizedBox(height: 20),

              // Action Buttons Row
              _buildActionButtons(),

              const SizedBox(height: 20),

              // Bio Container with styling
              _buildBioContainer(),

              const SizedBox(height: 20),

              // Username TextField for editing
              _buildUsernameTextField(),

              // Validation error message
              if (showValidationError) _buildValidationError(),

              // Spacer to push orientation info to bottom
              Spacer(),

              // Screen orientation display
              _buildOrientationInfo(orientationText),
            ],
          ),
        ),
      ),
    );
  }

  // Profile Image Widget with LOCAL asset image
  Widget _buildProfileImage() {
    return Center(
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.blue,
            width: 3,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipOval(
          child: Image.asset(
            'assets/images/pic.png', // Local image path
            fit: BoxFit.cover,
            width: 120,
            height: 120,
            // Fallback widget in case image fails to load
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.grey[300],
                child: Icon(
                  Icons.person,
                  size: 60,
                  color: Colors.grey[600],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  // User Information with RichText
  Widget _buildUserInfo() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black87,
        ),
        children: [
          TextSpan(
            text: '$username\n',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Colors.blue[800],
            ),
          ),
          TextSpan(
            text: email,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  // Action Buttons in a Row
  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Elevated Button for Edit
        ElevatedButton(
          onPressed: _handleEdit,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
          ),
          child: const Text('Edit Profile'),
        ),

        // Text Button for Cancel
        TextButton(
          onPressed: _handleCancel,
          style: TextButton.styleFrom(
            foregroundColor: Colors.grey[600],
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
          ),
          child: Text('Cancel'),
        ),
      ],
    );
  }

  // Bio Container with styling
  Widget _buildBioContainer() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue[100]!),
      ),
      child: Text(
        bio,
        style: TextStyle(
          fontSize: 14,
          color: Colors.blue[900],
          height: 1.4,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  // Username TextField for editing
  Widget _buildUsernameTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Edit Username:',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _usernameController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter your username',
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
        ),
      ],
    );
  }

  // Validation Error Widget
  Widget _buildValidationError() {
    return const Padding(
      padding: EdgeInsets.only(top: 8),
      child: Text(
        'Username cannot be empty',
        style: TextStyle(
          color: Colors.red,
          fontSize: 14,
        ),
      ),
    );
  }

  // Orientation Information Widget
  Widget _buildOrientationInfo(String orientationText) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.screen_rotation,
            color: Colors.grey[600],
            size: 16,
          ),
          const SizedBox(width: 8),
          Text(
            'Screen Orientation: $orientationText',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}