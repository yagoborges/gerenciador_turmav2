import 'package:gerenciador_turma/src/aluno/entity_aluno.dart';
import 'package:gerenciador_turma/src/turma/entity_turma.dart';

class TurmaXAluno {
  Aluno fk_txa_matricula;
  Turma fk_txa_cod_turma;

  TurmaXAluno(this.fk_txa_matricula, this.fk_txa_cod_turma);
}
