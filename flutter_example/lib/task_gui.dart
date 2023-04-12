import 'package:flutter/material.dart';
import 'package:flutter_example/main.dart';
import 'package:flutter_example/task_db.dart';
import 'package:flutter_example/task_obj.dart';


class TaskGUI extends StatefulWidget {
  const TaskGUI({Key? key}):super(key:key);

  @override
  NewTaskApp createState() => NewTaskApp();
}

class NewTaskApp extends State<TaskGUI>{
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MyApp()));
          },
        ),
        title: const Text('Agregar nueva tarea'),
        backgroundColor: Colors.deepPurpleAccent,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: TextFormField(
          restorationId: 'nameTask',
          controller: _nameController,
          textInputAction: TextInputAction.next,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            filled: true,
            icon: Icon(Icons.cloud_done),
            labelText: 'Ingresa tu nueva tarea',
            labelStyle: TextStyle(
              fontSize: 14,
              color: Color.fromARGB(255, 134, 21, 240)
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if(_nameController.text.isEmpty) {
            showDialog(context: context, builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Error al guardar la tarea'),
                content: const Text('Debes ingresar un texto para registrar como tarea.'),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Aceptar'),
                    onPressed: () { 
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            });
          } else {
            TaskObj taskObj = TaskObj( nameTask: _nameController.text, completedTask: 0);
            SQLiteDatabase sqLiteDatabase = SQLiteDatabase();
            sqLiteDatabase.createTask(taskObj);

            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MyApp()));
          }
        },
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.done),
      ),
    );
  }
}