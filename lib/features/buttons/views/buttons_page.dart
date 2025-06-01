import 'package:flutter/material.dart';

class ButtonsPage extends StatelessWidget {
  const ButtonsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Elevated Buttons',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue, // Change to your desired color
            ),
            onPressed: () {},
            child: const Text('Elevated Button'),
          ),
          const SizedBox(height: 20),

          Text('Filled Buttons', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 10),
          FilledButton(onPressed: () {}, child: const Text('Filled Button')),
          const SizedBox(height: 10),
          FilledButton.tonal(
            onPressed: () {},
            child: const Text('Tonal Button'),
          ),
          const SizedBox(height: 20),

          Text('Text Buttons', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 10),
          TextButton(onPressed: () {}, child: const Text('Text Button')),
          const SizedBox(height: 20),

          Text(
            'Outlined Buttons',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 10),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: const BorderSide(
                color: Colors.blue,
              ), // Change to your desired color
              backgroundColor: Colors.yellow,
            ),
            onPressed: () {},
            child: const Text(
              'Outlined Button',
              style: TextStyle(color: Colors.blue, fontSize: 16),
            ),
          ),
          const SizedBox(height: 20),

          Text('Icon Buttons', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 10),
          IconButton(onPressed: () {}, icon: const Icon(Icons.favorite)),
          const SizedBox(height: 20),

          Text('Custom Buttons', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 10),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.add),
            label: const Text('Button with Icon'),
          ),
        ],
      ),
    );
  }
}
