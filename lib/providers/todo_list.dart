import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'package:todo_provider/models/todo_model.dart';

class TododListState extends Equatable {
  final List<Todo> todos;

  const TododListState({
    required this.todos,
  });

  factory TododListState.initial() {
    return TododListState(todos: [
      Todo(id: '1', desc: 'Clean the room'),
      Todo(id: '2', desc: 'Wash the dish'),
      Todo(id: '3', desc: 'Do homework'),
    ]);
  }

  @override
  List<Object> get props => [todos];

  @override
  bool get stringify => true;

  TododListState copyWith({
    List<Todo>? todos,
  }) {
    return TododListState(
      todos: todos ?? this.todos,
    );
  }
}

class TodoList with ChangeNotifier {
  TododListState _state = TododListState.initial();
  TododListState get state => _state;

  void addTodo(String todoDesc) {
    final newTodo = Todo(desc: todoDesc);
    final newTodos = [..._state.todos, newTodo];

    _state = _state.copyWith(todos: newTodos);
    notifyListeners();
  }

  void editTodo(String id, String todoDesc) {
    final newTodos = _state.todos.map((Todo todo) {
      if (todo.id == id) {
        return Todo(id: id, desc: todoDesc, completed: todo.completed);
      }
      return todo;
    }).toList();

    _state = _state.copyWith(todos: newTodos);
    notifyListeners();
  }

  void tongleTodo(String id) {
    final newTodos = _state.todos.map((Todo todo) {
      if (todo.id == id) {
        return Todo(id: id, desc: todo.desc, completed: !todo.completed);
      }
      return todo;
    }).toList();

    _state = _state.copyWith(todos: newTodos);
    notifyListeners();
  }

  void removeTodo(Todo todo) {
    final newTodos = _state.todos.where((Todo t) => t.id != todo.id).toList();

    _state = _state.copyWith(todos: newTodos);
    notifyListeners();
  }
}
