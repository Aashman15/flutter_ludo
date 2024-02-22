import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ludo/screens/initializer/initializer_screen.dart';

void main(List<String> args) {
  runApp(
    const ProviderScope(
      child: MaterialApp(
        home: InitializerScreen(),
      ),
    ),
  );
}
