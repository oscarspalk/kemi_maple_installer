import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:kemi_installer/dialogs/file_location_screen.dart';
import 'package:macos_ui/macos_ui.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MacosApp(
      theme: MacosThemeData.dark(),
      home: const MacosWindow(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: FileLocationScreen(),
        ),
      ),
    );
  }
}
