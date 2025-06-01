import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_app/core/providers/shared_prefs_service.dart';
import 'package:test_app/features/forget_password/forget_password_page.dart';
import 'package:test_app/features/setting/viewmodels/theme_viewmodel.dart';
// import 'package:test_app/features/widget_tree.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefsService.init();
  runApp(const ProviderScope(child: MyApp()));
}

// 1. MaterialApp
// - Widget gốc của ứng dụng Flutter
// - Cung cấp nhiều tính năng material design
// - Quản lý routing/navigation
// - Cấu hình theme
// - Hỗ trợ đa ngôn ngữ (localization)
// - Debug banner

// 2. Scaffold
// - Layout cơ bản của một màn hình
// - AppBar: thanh tiêu đề ở trên
// - Body: nội dung chính
// - BottomNavigationBar: thanh điều hướng dưới
// - FloatingActionButton: nút nổi góc phải
// - Drawer: menu trượt từ cạnh
// - BottomSheet: panel trượt từ dưới lên

// 3. Container
// - Widget đa năng để tạo box
// - Có thể set màu, kích thước, padding, margin
// - Decoration để tạo border, shadow, gradient
// - Transform để xoay, scale, di chuyển
// - Constraints để giới hạn kích thước

// 4. Layout Widgets
// Row: sắp xếp các widget theo chiều ngang
// Column: sắp xếp các widget theo chiều dọc
// Stack: xếp chồng các widget lên nhau
// Wrap: tự động xuống dòng khi hết không gian
// ListView: danh sách có thể cuộn
// GridView: lưới các item

// 5. Gesture Widgets
// GestureDetector: phát hiện các cử chỉ (tap, double tap, long press)
// InkWell: hiệu ứng gợn sóng khi tap
// DragTarget: nhận các widget được kéo thả
// LongPressDraggable: cho phép kéo thả widget

// 6. Input Widgets
// TextField: nhập text
// Checkbox: tích chọn
// Radio: chọn một trong nhiều
// Switch: bật/tắt
// Slider: chọn giá trị trong khoảng
// DatePicker: chọn ngày

// 7. Display Widgets
// Text: hiển thị text
// Image: hiển thị hình ảnh
// Icon: hiển thị icon
// Card: hiển thị thông tin dạng card
// Chip: hiển thị thông tin nhỏ gọn
// ProgressIndicator: hiển thị tiến trình

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // return ValueListenableBuilder<bool>(
    //   valueListenable: isDarkModeNotifier,
    //   builder: (context, isDarkModeNotifier, child) {
    //     return MaterialApp(
    //       debugShowCheckedModeBanner: false,
    //       theme:
    //           isDarkModeNotifier
    //               ? AppTheme.darkThemeMode
    //               : AppTheme.lightThemeMode,
    //       home: LoginPage(),
    //     );
    //   },
    // );
    // return ValueListenableBuilder<bool>(
    //   valueListenable: isDarkModeNotifier,
    //   builder: (context, isDarkMode, child) {
    //     return MaterialApp(
    //       debugShowCheckedModeBanner: false,
    //       theme: isDarkMode ? AppTheme.darkThemeMode : AppTheme.lightThemeMode,
    //       home: const WidgetTree(),
    //     );
    //   },
    // );
    final isDarkMode = ref.watch(themeProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: const ForgetpasswordPage(),
    );
  }
}
