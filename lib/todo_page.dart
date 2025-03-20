import 'package:flutter/material.dart';

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Manager',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 0, 174, 255)),
        useMaterial3: true,
      ),
      home: const TaskManagerScreen(),
    );
  }
}

class TaskManagerScreen extends StatefulWidget {
  const TaskManagerScreen({super.key});

  @override
  State<TaskManagerScreen> createState() => _TaskManagerScreenState();
}

class _TaskManagerScreenState extends State<TaskManagerScreen> {
  final _taskController = TextEditingController();
  DateTime? _selectedDate;
  final List<Map<String, dynamic>> _tasks = [];
  String? _taskError;
  String? _dateError;

  void _addTask() {
  setState(() {
    _taskError = _taskController.text.isEmpty ? "Task tidak boleh kosong!" : null;
    _dateError = _selectedDate == null ? "Tanggal harus dipilih!" : null;

    if (_taskError == null && _dateError == null) {
      _tasks.add({
        'task': _taskController.text,
        'date': _selectedDate!,
        'done': false,
      });
      _taskController.clear();
      _selectedDate = null;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Container(
            width: double.infinity, 
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16), 
            decoration: BoxDecoration(
              color: Colors.teal,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              "Task added successfully",
              textAlign: TextAlign.left, 
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w400, 
          ),
        ),
          ),
        ),
      );
    }
  });
}
}