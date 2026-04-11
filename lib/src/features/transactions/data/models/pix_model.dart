import 'package:pix_bb/src/features/transactions/domain/entities/pix.dart';

class PagadorModel extends Pagador {
  const PagadorModel({
    required super.nome,
    super.cpf,
    super.cnpj,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nome': nome,
      'cpf': cpf,
      'cnpj': cnpj,
    };
  }

  factory PagadorModel.fromMap(Map<String, dynamic> map) {
    return PagadorModel(
      nome: map['nome'] as String,
      cpf: map['cpf'] as String?,
      cnpj: map['cnpj'] as String?,
    );
  }
}

class PixModel extends Pix {
  const PixModel({
    super.endToEndId,
    required super.valor,
    required super.horario,
    required super.pagador,
    required super.infoPagador,
    super.txid,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'endToEndId': endToEndId,
      'valor': valor,
      'horario': horario,
      'pagador': (pagador as PagadorModel).toMap(),
      'infoPagador': infoPagador,
      'txid': txid,
    };
  }

  factory PixModel.fromMap(Map<String, dynamic> map) {
    return PixModel(
      endToEndId: map['endToEndId'] as String?,
      valor: map['valor'] as String,
      horario: map['horario'] as String,
      pagador: PagadorModel.fromMap(map['pagador'] as Map<String, dynamic>),
      infoPagador: map['infoPagador'] as String,
      txid: map['txid'] as String?,
    );
  }
}
