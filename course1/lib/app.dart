import 'package:flutter/material.dart';
import 'package:user_repository/user_repository.dart';

class MyApp extends StatelessWidget {
  final UserRepository userRepository;

  // Correctly assigning the parameter to the class property
  const MyApp({super.key, required this.userRepository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App Title',
      home: Scaffold(
        appBar: AppBar(
          title: Text('My App'),
        ),
        body: const Placeholder(), // You can replace this with your actual widget tree
      ),
    );
  }
}
