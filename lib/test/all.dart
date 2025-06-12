import 'package:flutter/material.dart';
import 'package:learning_flutter/test/profile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  Widget _buildListTile(String name, String role, String avatarUrl) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.blue.withValues(alpha: 0.3),
        // splashColor: Color.fromRGBO(255, 255, 255, 0.3),
        onTap: () {
          debugPrint("$name clicked!");
        },
        child: ListTile(
          leading: CircleAvatar(backgroundImage: NetworkImage(avatarUrl)),
          title: Text(name),
          subtitle: Text(role),
          trailing: const Icon(Icons.call),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        leading: IconButton(icon: const Icon(Icons.menu), onPressed: () {}),
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          IconButton(icon: const Icon(Icons.notifications), onPressed: () {}),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        // decoration: const BoxDecoration(
        //   image: DecorationImage(
        //     image: NetworkImage('https://i.pravatar.cc/800'),
        //     fit: BoxFit.cover,
        //   ),
        // ),
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(
        //     colors: [Colors.blue.withOpacity(0.5), Colors.red.withOpacity(0.5)],
        //     begin: Alignment.topLeft,
        //     end: Alignment.bottomRight,
        //   ),
        // ),
        // decoration: BoxDecoration(
        //   gradient: const RadialGradient(
        //     colors: [Colors.blue, Colors.red],
        //     center: Alignment(0.0, 0.0),
        //     radius: 1.0,
        //   ),
        // ),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Image.asset('assets/images/bg.jpg').image,
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.all(16),
              width: 100,
              height: 100,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.amber[600],
                image: DecorationImage(
                  image: NetworkImage('https://i.pravatar.cc/300'),
                  fit: BoxFit.cover,
                ),
                border: Border.all(color: Colors.red),
                borderRadius: BorderRadius.circular(100),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(51, 0, 0, 0),
                    offset: Offset(0, 2),
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Text(
                '$_counter',
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),

            const ProfileCard(),
            Column(
              children: [
                _buildListTile(
                  'Nguyễn Văn A',
                  'Mobile Developer',
                  'https://i.pravatar.cc/200',
                ),
                _buildListTile(
                  'Trần Thị B',
                  'UI/UX Designer',
                  'https://i.pravatar.cc/400',
                ),
                _buildListTile(
                  'Phạm Văn C',
                  'Backend Developer',
                  'https://i.pravatar.cc/500',
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _decrementCounter,
            tooltip: 'Decrement',
            backgroundColor: Colors.red,
            child: const Icon(Icons.remove),
          ),
          const SizedBox(width: 16),
          FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            backgroundColor: Colors.blue,
            child: const Icon(Icons.add, color: Colors.white),
          ),
          const SizedBox(width: 16),
          ElevatedButton(
            onPressed: _resetCounter,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              minimumSize: const Size(55, 55),
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(16),
            ),
            child: const Icon(Icons.check, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
