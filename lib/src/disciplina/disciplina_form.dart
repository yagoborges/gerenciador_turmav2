import 'package:flutter/material.dart';

class DisciplinaForm extends StatelessWidget {
  const DisciplinaForm({super.key});

  Widget nomeDisciplina() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Nome Disciplina'),
    );
  }

  Widget ProfessorDisc() {
    return DropdownButton(items: null, onChanged: (onChanged) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Disciplinas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              nomeDisciplina(),
              const SizedBox(
                height: 15,
              ),
              ProfessorDisc(),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {},
        child: const Icon(Icons.check),
      ),
    );
  }
}
