import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/commons/router/router.gr.dart';
import 'package:todo_app/features/task/bloc/task_bloc.dart';
import 'package:todo_app/gen/colors.gen.dart';
import 'package:todo_app/injections.dart';
import 'package:todo_app/repos/task/task_repository.dart';

class TaskTabPage extends StatelessWidget with AutoRouteWrapper {
  const TaskTabPage({Key? key}) : super(key: key);

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                AllTaskBloc(taskRepository: getIt<ITaskRepository>())),
        BlocProvider(
            create: (context) =>
                CompleteTaskBloc(taskRepository: getIt<ITaskRepository>())),
        BlocProvider(
            create: (context) =>
                IncompleteTaskBloc(taskRepository: getIt<ITaskRepository>())),
      ],
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [
        AllTaskRoute(),
        CompleteTaskRoute(),
        IncompleteTaskRoute(),
      ],
      builder: (context, child, animation) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          backgroundColor: ColorName.background,
          body: FadeTransition(
            opacity: animation,
            child: child,
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: ColorName.secondaryBackground,
            selectedItemColor: ColorName.primary,
            unselectedItemColor: ColorName.secondaryText,
            currentIndex: tabsRouter.activeIndex,
            elevation: 0.0,
            enableFeedback: true,
            type: BottomNavigationBarType.fixed,
            selectedFontSize: 14.0,
            unselectedFontSize: 14.0,
            onTap: (index) => tabsRouter.setActiveIndex(index),
            items: const [
              BottomNavigationBarItem(
                  label: 'Todas', icon: Icon(Icons.checklist_rounded)),
              BottomNavigationBarItem(
                  label: 'Completas',
                  icon: Icon(Icons.check_circle_outline_rounded)),
              BottomNavigationBarItem(
                  label: 'Incompletas',
                  icon: Icon(Icons.radio_button_unchecked_rounded)),
            ],
          ),
        );
      },
    );
  }
}
