import 'package:flutter/material.dart';
import 'package:flutter_example/task_db.dart';
import 'package:flutter_example/task_gui.dart';
import 'package:flutter_example/task_obj.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'TaskList',
      home: MyHomeMain(),
    );
  }
}

class MyHomeMain extends StatefulWidget {
  const MyHomeMain({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyHomeMain createState() => _MyHomeMain();
}

class _MyHomeMain extends State<MyHomeMain> {

  late SQLiteDatabase sqLiteDatabase;
  List<TaskObj> tasks = [];

  @override
  void initState() {
    super.initState();
    sqLiteDatabase = SQLiteDatabase();
    sqLiteDatabase.initDB().then((value) {
      sqLiteDatabase.getTasks().then((value) {
        setState(() {
          tasks = value;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        title: const Text(
          "Lista de tareas", style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold
          ),
        ),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: ListView(
        restorationId: 'listTaskID',
        padding: const EdgeInsets.symmetric(vertical: 10),
        children: [
            Image.network("https://i.imgur.com/kmom8s0.gif",
            width: 50,
            height: 50,),
            ...tasks.map((task) {
            return CheckboxListTile(
              title: Text(task.nameTask),
              value: task.completedTask == 1,
              onChanged: (value) {
                setState(() {
                  task.completedTask = value! ? 1:0;
                  if(task.completedTask == 1){
                    Future.delayed(const Duration(milliseconds: 800), (){
                        sqLiteDatabase.deleteTask(task.nameTask);
                        sqLiteDatabase.getTasks().then((value) {
                        setState(() {
                          tasks = value;
                        });
                      });
                    });
                  }
                });
              },
            );
            }).toList(),
          ]
        ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const TaskGUI())
          );
        },
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add),
      ),
    );
  }
}