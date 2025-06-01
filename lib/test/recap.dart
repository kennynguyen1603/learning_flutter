import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// MaterialApp là widget gốc của ứng dụng Flutter (như Theme và Navigator)
// Scaffold là widget cơ bản để tạo giao diện với AppBar, Body, BottomNavigationBar, FloatingActionButton
// Drawer là widget để tạo menu bên trái
// AppBar là thanh tiêu đề của ứng dụng
// AppBar có thể chứa các widget như IconButton, Text, DropdownButton, Action
// FloatingActionButton là nút nổi để thực hiện hành động chính
// bottomNavigationBar là thanh điều hướng ở dưới cùng của ứng dụng
// SafeArea là widget để đảm bảo nội dung không bị che khuất bởi các yếu tố như notch, status bar, navigation bar

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.dark,
        ),
      ),
      home: MyCounter(),
    );
  }
}

// StatelessWidget là widget không thay đổi trạng thái
// StatefulWidget là widget có thể thay đổi trạng thái
// StatelessWidget có thể được sử dụng để tạo các widget đơn giản mà không cần quản lý trạng thái
// StatefulWidget được sử dụng khi bạn cần quản lý trạng thái của widget, ví dụ như khi bạn cần thay đổi giao diện dựa trên dữ liệu hoặc tương tác của người dùng

class MyCounter extends StatefulWidget {
  const MyCounter({super.key});

  @override
  State<MyCounter> createState() => _MyCounterState();
}

class _MyCounterState extends State<MyCounter> {
  // có thể viết code ở đây
  int currentIndex = 0;
  int count = 0;

  void setCurrentIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  void increment() {
    setState(() {
      count++;
    });
  }

  void decrement() {
    setState(() {
      count--;
    });
  }

  void reset() {
    setState(() {
      count = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    // có thể viết code ở đây
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter App'),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('You have pushed the button this many times:'),
            Text('$count', style: Theme.of(context).textTheme.headlineLarge),
            ElevatedButton(
              onPressed: () {
                reset();
              },
              child: const Text('Reset'),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text('Drawer Header'),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                debugPrint("Home clicked!");
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                debugPrint("Settings clicked!");
              },
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        // mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            onPressed: () {
              increment();
            },
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () {
              decrement();
            },
            child: const Icon(Icons.remove),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        destinations: [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.search), label: 'Search'),
          NavigationDestination(icon: Icon(Icons.settings), label: 'Settings'),
        ],
        selectedIndex: currentIndex, // Chỉ định chỉ số của mục được chọn
        onDestinationSelected: (value) {
          setCurrentIndex(value); // Cập nhật chỉ số của mục được chọn
          debugPrint("Selected index: $value");
        },
      ),
    );
  }
}
