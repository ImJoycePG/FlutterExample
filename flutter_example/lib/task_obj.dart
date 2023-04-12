class TaskObj {
  final String nameTask;
  int completedTask;

  TaskObj({required this.nameTask, required this.completedTask});

  Map<String, dynamic> toMap() {
    return {'nameTask': nameTask, 'completedTask': completedTask};
  }
}