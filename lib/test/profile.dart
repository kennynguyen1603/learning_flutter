import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Profile Card'),
          backgroundColor: Colors.deepPurple,
        ),
        body: const Center(child: ProfileCard()),
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  Widget _buildChip(String label, Color color) {
    return Chip(
      label: Text(label),
      backgroundColor: color,
      labelStyle: const TextStyle(color: Colors.white),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Avatar và thông tin cá nhân
            const Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(
                    'https://i.pravatar.cc/300',
                  ), // Ảnh đại diện giả lập
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'John Doe',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Software Developer',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Mô tả ngắn gọn
            const Text(
              'Passionate about building scalable software, creating effective solutions, and learning every day to grow professionally.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),

            // Danh sách kỹ năng
            Wrap(
              spacing: 8.0, // Khoảng cách ngang
              runSpacing: 4.0, // Khoảng cách dọc
              alignment: WrapAlignment.start,
              children: <Widget>[
                _buildChip('Flutter', Colors.blue),
                _buildChip('Dart', Colors.green),
                _buildChip('Firebase', Colors.orange),
                _buildChip('React Native', Colors.purple),
                _buildChip('Node.js', Colors.red),
                _buildChip('MongoDB', Colors.teal),
                _buildChip('JavaScript', Colors.yellow),
                _buildChip('TypeScript', Colors.pink),
              ],
            ),
            const SizedBox(height: 16),

            // Nút hành động
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                  ),
                  child: const Text('Follow'),
                ),
                OutlinedButton(onPressed: () {}, child: const Text('Message')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
