import 'package:flutter/material.dart';
import 'package:gerenciador_turma/src/shared/app_scaffold.dart';

class TurmaPage extends StatelessWidget {
  const TurmaPage({super.key});

  @override
  Widget build(BuildContext context) {
    //final authService = Provider.of<AuthService>(context);
    final listaTurmas = [
      {
        'cod_turma': '1',
        'nome_disc': 'Educação Matemática',
        'anosem': '2023/01',
        'nome_prof': 'Thiago Porto'
      },
      {
        'cod_turma': '2',
        'nome_disc': 'Desenvolvimento Mobile',
        'anosem': '2023/01',
        'nome_prof': 'Laura Beatriz'
      },
      {
        'cod_turma': '3',
        'nome_disc': 'Análise de Sistemas',
        'anosem': '2023/01',
        'nome_prof': 'Lacordaire Kermel Cury'
      },
    ];

    return AppScaffold(
      pageTitle: const Text('Turmas'),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: listaTurmas.length,
        itemBuilder: (context, i) {
          var turmas = listaTurmas[i];
          return ListTile(
            title: Text("${turmas['nome_disc']} - ${turmas['anosem']}"),
            subtitle: Text("Professor(a): ${turmas['nome_prof']}"),
            trailing: SizedBox(
              width: 120,
              child: Row(children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.remove_red_eye_rounded),
                  color: Colors.grey,
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.edit),
                  color: Colors.orange,
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.delete),
                  color: Colors.red,
                ),
              ]),
            ),
          );
        },
      ),
    );
  }
}
