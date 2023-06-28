import 'package:gerenciador_turma/src/professor/entity_professor.dart';

class Disciplina {
  int cod_disc;
  String nome_disc;
  Professor fk_cod_prof;

  Disciplina(this.cod_disc, this.nome_disc, this.fk_cod_prof);
}
