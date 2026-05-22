import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talktou_app/src/screens/TaskDetail_screen.dart';

class TaskManager extends StatefulWidget {
  const TaskManager({super.key});

  @override
  State<TaskManager> createState() => _TaskManagerState();
}

class _TaskManagerState extends State<TaskManager> {
  
  final List<Map<String, dynamic>> _tasks = [];

  void _navigateToTaskDetail({int? index}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => index != null
            ? TaskDetailScreen(
                title: _tasks[index]["title"],
                description: _tasks[index]["description"],
                isEditing: true,
              )
            : const TaskDetailScreen(),
      ),
    );

    if (result != null) {
      setState(() {
        if (result == "delete" && index != null) {
          _tasks.removeAt(index);
        } else if (index != null) {
          // Editando tarefa existente
          _tasks[index]["title"] = result["title"];
          _tasks[index]["description"] = result["description"];
        } else {
          // Criando nova tarefa
          _tasks.add({
            "title": result["title"],
            "description": result["description"],
            "done": false,
          });
        }
      });
    }
  }

  void _toggleTask(int index) {
    setState(() {
      _tasks[index]["done"] = !_tasks[index]["done"];
    });
  }

  @override
  Widget build(BuildContext context) {
    TextStyle getAppFont({double? fontSize, FontWeight? fontWeight, TextDecoration? decoration, Color? color}) {
      return GoogleFonts.poppins(
        fontSize: fontSize,
        fontWeight: fontWeight,
        decoration: decoration,
        color: color,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (int i = 0; i < _tasks.length; i++)
          Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              leading: IconButton(
                icon: Icon(
                  _tasks[i]["done"] ? Icons.check_circle : Icons.radio_button_unchecked,
                  color: _tasks[i]["done"] ? Colors.green : Colors.grey,
                  size: 28,
                ),
                onPressed: () => _toggleTask(i),
              ),
              title: Text(
                _tasks[i]["title"],
                style: getAppFont(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  decoration: _tasks[i]["done"] ? TextDecoration.lineThrough : null,
                  color: _tasks[i]["done"] ? Colors.grey : Colors.black87,
                ),
              ),
              subtitle: _tasks[i]["description"] != null && _tasks[i]["description"]!.isNotEmpty
                  ? Text(
                      _tasks[i]["description"]!,
                      style: getAppFont(fontSize: 13, color: Colors.grey[600]),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )
                  : null,
              trailing: const Icon(Icons.chevron_right, color: Colors.blueAccent),
              onTap: () => _navigateToTaskDetail(index: i),
            ),
          ),
        const SizedBox(height: 24),
        ElevatedButton.icon(
          onPressed: () => _navigateToTaskDetail(),
          icon: const Icon(Icons.add, color: Colors.white),
          label: Text(
            "ADICIONAR NOVA TAREFA",
            style: getAppFont(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 2,
          ),
        ),
      ],
    );
  }
}