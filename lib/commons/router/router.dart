import 'package:auto_route/auto_route.dart';
import 'package:todo_app/features/task/pages/all_task_page.dart';
import 'package:todo_app/features/task/pages/complete_task_page.dart';
import 'package:todo_app/features/task/pages/incomplete_task_page.dart';
import 'package:todo_app/features/task/pages/task_tab_page.dart';

@AdaptiveAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: [
    AutoRoute(
      path: '/tarefas',
      page: TaskTabPage,
      initial: true,
      children: [
        AutoRoute(path: '', page: AllTaskPage),
        AutoRoute(path: 'completa', page: CompleteTaskPage),
        AutoRoute(path: 'incompleta', page: IncompleteTaskPage),
      ],
    ),
  ],
)
class $AppRouter {}
