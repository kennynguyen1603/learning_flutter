import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learning_flutter/core/constants/constants.dart';
import 'package:learning_flutter/core/providers/navigation_provider.dart';
import 'package:learning_flutter/core/widgets/navbar_widget.dart';
import 'package:learning_flutter/features/home/views/home_page.dart';
import 'package:learning_flutter/features/search/views/search_page.dart';
import 'package:learning_flutter/features/buttons/views/buttons_page.dart';
import 'package:learning_flutter/features/gestures/views/gestures_page.dart';
import 'package:learning_flutter/features/setting/viewmodels/theme_viewmodel.dart';
import 'package:learning_flutter/features/setting/views/settings_page.dart';

List<Widget> pages = [HomePage(), SearchPage(), GesturesPage(), ButtonsPage()];

class WidgetTree extends ConsumerStatefulWidget {
  const WidgetTree({super.key});

  @override
  ConsumerState<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends ConsumerState<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Widget Tree', style: KTextStyle.title),
        actions: [
          // IconButton(
          //   icon: ValueListenableBuilder(
          //     valueListenable: isDarkModeNotifier,
          //     builder: (context, value, child) {
          //       return Icon(
          //         value ? Icons.light_mode : Icons.dark_mode,
          //         color: value ? Colors.white : Colors.black,
          //       );
          //     },
          //   ),
          //   onPressed: () {
          //     isDarkModeNotifier.value = !isDarkModeNotifier.value;
          //   },
          // ),

          // IconButton(
          //   icon: ValueListenableBuilder(
          //     valueListenable: isDarkModeNotifier,
          //     builder: (context, isDarkMode, child) {
          //       return Icon(
          //         isDarkMode ? Icons.light_mode : Icons.dark_mode,
          //         color: isDarkMode ? Colors.white : Colors.black,
          //       );
          //     },
          //   ),
          //   onPressed: () async {
          //     isDarkModeNotifier.value = !isDarkModeNotifier.value;
          //     await SharedPrefsService.setIsDarkMode(isDarkModeNotifier.value);
          //   },
          // ),
          Consumer(
            builder: (context, ref, child) {
              final isDarkMode = ref.watch(themeProvider);
              return IconButton(
                icon:
                    isDarkMode
                        ? const Icon(Icons.light_mode)
                        : const Icon(Icons.dark_mode),
                onPressed: () {
                  ref.read(themeProvider.notifier).toggleTheme();
                },
              );
            },
          ),

          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const SettingsPage(title: 'Settings Page');
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final selectedPage = ref.watch(selectedPageProvider);
          return pages[selectedPage];
        },
      ),
      bottomNavigationBar: NavbarWidget(),
    );
  }
}
