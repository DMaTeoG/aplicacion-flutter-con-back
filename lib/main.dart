import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:get/get.dart';
import 'screens/item_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 🚨 AQUÍ VA TU URL Y ANON KEY DE SUPABASE
  await Supabase.initialize(
    url: 'https://xajcaywfkmaujziejaux.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhhamNheXdma21hdWp6aWVqYXV4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTg3NjQ5NDksImV4cCI6MjA3NDM0MDk0OX0.g05aWQblZ3OnNIwofLMT-SJIVbraeJR7c_hTkg-6JUk',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Sistema de Reviews',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const ItemListScreen(),
    );
  }
}
