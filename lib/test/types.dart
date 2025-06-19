import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// Định nghĩa các kiểu dữ liệu
enum Gender { male, female, other }

class User {
  final String name;
  final int age;
  final Gender gender;
  final List<String> hobbies;
  final Map<String, String> friends;

  User({
    required this.name,
    required this.age,
    required this.gender,
    required this.hobbies,
    required this.friends,
  });
}

// Hàm giả lập lấy thông tin người dùng từ server (2 giây)
Future<User> fetchUserData() async {
  await Future.delayed(const Duration(seconds: 2));
  return User(
    name: "Alice Johnson",
    age: 25,
    gender: Gender.female,
    hobbies: ["Reading", "Traveling", "Photography"],
    friends: {
      "John": "Best Friend",
      "Emma": "Colleague",
      "Michael": "Neighbor",
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Info App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const UserInfoPage(),
    );
  }
}

class UserInfoPage extends StatefulWidget {
  const UserInfoPage({super.key});

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  late Future<User> userFuture;

  @override
  void initState() {
    super.initState();
    userFuture = fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông Tin Người Dùng'),
        centerTitle: true,
      ),
      body: FutureBuilder<User>(
        future: userFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Lỗi: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final user = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '👤 Tên: ${user.name}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('🎂 Tuổi: ${user.age}'),
                  const SizedBox(height: 8),
                  Text(
                    '🚻 Giới tính: ${user.gender == Gender.male ? "Nam" : user.gender == Gender.female ? "Nữ" : "Khác"}',
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    '💡 Sở thích:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  for (var hobby in user.hobbies)
                    Padding(
                      padding: const EdgeInsets.only(left: 16, top: 4),
                      child: Text('- $hobby'),
                    ),
                  const SizedBox(height: 16),
                  const Text(
                    '👥 Bạn bè:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  for (var entry in user.friends.entries)
                    Padding(
                      padding: const EdgeInsets.only(left: 16, top: 4),
                      child: Text('- ${entry.key}: ${entry.value}'),
                    ),
                ],
              ),
            );
          } else {
            return const Center(child: Text('Không có dữ liệu.'));
          }
        },
      ),
    );
  }
}
