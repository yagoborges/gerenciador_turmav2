import 'package:flutter/material.dart';
import 'package:gerenciador_turma/src/aluno/aluno_form.dart';
import 'package:gerenciador_turma/src/aluno/aluno_page.dart';
import 'package:gerenciador_turma/src/disciplina/disciplina_form.dart';
import 'package:gerenciador_turma/src/disciplina/disciplina_page.dart';
import 'package:gerenciador_turma/src/login/login.dart';
import 'package:gerenciador_turma/src/professor/professor_form.dart';
import 'package:gerenciador_turma/src/professor/professor_page.dart';
import 'package:gerenciador_turma/src/turma/turma_form.dart';
import 'package:gerenciador_turma/src/turma/turma_page.dart';

import 'package:gerenciador_turma/src/themes/color_schemes.g.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gerenciador de Turmas',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
        ),
      ),
      /* darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: darkColorScheme,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
        ),
      ),*/
      initialRoute: '/login_page',
      routes: {
        '/professor_page': (context) => const ProfessorPage(),
        '/disciplina_page': (context) => const DisciplinaPage(),
        '/turma_page': (context) => const TurmaPage(),
        '/aluno_page': (context) => AlunoPage(),
        '/login_page': (context) => Login(),
        '/aluno_form': (context) => AlunoForm(),
        '/disciplina_form': (context) => const DisciplinaForm(),
        '/professor_form': (context) => ProfessorForm(),
        '/turma_form': (context) => const TurmaForm(),
      },
    );
  }
}
