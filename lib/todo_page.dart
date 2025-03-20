import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

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
            backgroundColor: Colors.transparent, 
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 5), 
            duration: const Duration(seconds: 10),
          ),
        );
      }
    });
  }

  void _toggleTaskStatus(int index) {
    setState(() {
      _tasks[index]['done'] = !_tasks[index]['done'];
    });
  }

void _showCupertinoDatePicker(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext builder) {
      return SizedBox(
        height: 300,
        child: Column(
          children: [
            Expanded(
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: _selectedDate ?? DateTime.now(),
                minimumYear: 2000,
                maximumYear: 2100,
                onDateTimeChanged: (DateTime newDate) {
                  setState(() {
                    _selectedDate = newDate;
                    _dateError = null;
                  });
                },
              ),
            ),
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Done", style: TextStyle(fontSize: 16)),
            )
          ],
        ),
      );
    },
  );
}

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Manager'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Task Date:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            GestureDetector(
              onTap: () => _showCupertinoDatePicker(context),
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),

}