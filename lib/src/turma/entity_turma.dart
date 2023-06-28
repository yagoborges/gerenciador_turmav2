import 'package:gerenciador_turma/src/disciplina/entity_disciplina.dart';

class Turma {
  int cod_turma;
  Disciplina fk_cod_disc;
  String anosem;

  Turma(this.cod_turma, this.fk_cod_disc, this.anosem);
}
