import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'package:todo_provider/models/todo_model.dart';
import 'package:todo_provider/providers/providers.dart';

class FilteredTodosState extends Equatable {
  final List<Todo> filteredTodos;

  const FilteredTodosState({
    required this.filteredTodos,
  });

  factory FilteredTodosState.initial() {
    return const FilteredTodosState(filteredTodos: []);
  }

  @override
  List<Object> get props => [filteredTodos];

  @override
  bool get stringify => true;

  FilteredTodosState copyWith({
    List<Todo>? filteredTodos,
  }) {
    return FilteredTodosState(
      filteredTodos: filteredTodos ?? this.filteredTodos,
    );
  }
}

class FilteredTodos with ChangeNotifier {
  // FilteredTodosState _state = FilteredTodosState.initial();

  late FilteredTodosState _state;
  final List<Todo> initialFilteredTodos;

  FilteredTodos({
    required this.initialFilteredTodos,
  }) {
    _state = FilteredTodosState(filteredTodos: initialFilteredTodos);
  }
  FilteredTodosState get state => _state;

  void update(
    TodoFilter todoFilter,
    TodoSearch todoSearch,
    TodoList todoList,
  ) {
    // ignore: no_leading_underscores_for_local_identifiers
    List<Todo> _filteredTodo;

    switch (todoFilter.state.filter) {
      case Filter.active:
        _filteredTodo =
            todoList.state.todos.where((Todo todo) => !todo.completed).toList();
        break;
      case Filter.completed:
        _filteredTodo =
            todoList.state.todos.where((Todo todo) => todo.completed).toList();
      case Filter.all:
      default:
        _filteredTodo = todoList.state.todos;
        break;
    }

    if (todoSearch.state.searchTerm.isNotEmpty) {
      _filteredTodo = _filteredTodo
          .where((Todo todo) => todo.desc
              .toLowerCase()
              .contains(todoSearch.state.searchTerm.toLowerCase()))
          .toList();
    }

    _state = _state.copyWith(filteredTodos: _filteredTodo);
    notifyListeners();
  }
}
