import 'package:equatable/equatable.dart';

class Pagador extends Equatable {
  final String nome;
  final String? cpf;
  final String? cnpj;

  const Pagador({
    required this.nome,
    this.cpf,
    this.cnpj,
  });

  @override
  List<Object?> get props => [nome, cpf, cnpj];
}

class Pix extends Equatable {
  final String? endToEndId;
  final String valor;
  final String horario;
  final Pagador pagador;
  final String infoPagador;
  final String? txid;

  const Pix({
    this.endToEndId,
    required this.valor,
    required this.horario,
    required this.pagador,
    required this.infoPagador,
    this.txid,
  });

  @override
  List<Object?> get props => [endToEndId, valor, horario, pagador, infoPagador, txid];
}
