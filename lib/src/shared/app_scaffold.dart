import 'package:flutter/material.dart';
import 'package:gerenciador_turma/src/shared/app_drawer.dart';

class AppScaffold extends StatelessWidget {
  final Widget? pageTitle;
  final Widget? child;
  final FloatingActionButton? floatingActionButton;
  final Widget? drawer;

  const AppScaffold({
    super.key,
    this.child,
    this.pageTitle,
    this.floatingActionButton,
    this.drawer,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatingActionButton,
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: pageTitle,
        centerTitle: true,
      ),
      body: child,
    );
  }
}
