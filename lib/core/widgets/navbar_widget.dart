import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learning_flutter/core/providers/navigation_provider.dart';

class NavbarWidget extends ConsumerWidget {
  const NavbarWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedPage = ref.watch(selectedPageProvider);
    return NavigationBar(
      backgroundColor: Colors.tealAccent,
      indicatorColor: Colors.white,
      labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
      destinations: const [
        NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
        NavigationDestination(icon: Icon(Icons.search), label: 'Search'),
        NavigationDestination(icon: Icon(Icons.touch_app), label: 'Gestures'),
        NavigationDestination(icon: Icon(Icons.smart_button), label: 'Buttons'),
      ],
      selectedIndex: selectedPage,
      onDestinationSelected: (int value) {
        ref.read(selectedPageProvider.notifier).state = value;
      },
    );
  }
}
