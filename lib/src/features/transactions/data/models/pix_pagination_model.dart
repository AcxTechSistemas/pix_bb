import 'package:pix_bb/src/features/transactions/domain/entities/pix_pagination.dart';

class PixPaginationModel extends PixPagination {
  const PixPaginationModel({
    required super.paginaAtual,
    required super.itensPorPagina,
    required super.quantidadeDePaginas,
    required super.quantidadeTotalDeItens,
  });

  factory PixPaginationModel.fromMap(Map<String, dynamic> map) {
    return PixPaginationModel(
      paginaAtual: map['paginaAtual'] as int,
      itensPorPagina: map['itensPorPagina'] as int,
      quantidadeDePaginas: map['quantidadeDePaginas'] as int,
      quantidadeTotalDeItens: map['quantidadeTotalDeItens'] as int,
    );
  }
}

class TransactionParamsModel extends TransactionParams {
  const TransactionParamsModel({
    required super.inicio,
    required super.fim,
    required super.paginacao,
  });

  factory TransactionParamsModel.fromMap(Map<String, dynamic> map) {
    return TransactionParamsModel(
      inicio: map['inicio'] as String,
      fim: map['fim'] as String,
      paginacao: PixPaginationModel.fromMap(map['paginacao'] as Map<String, dynamic>),
    );
  }
}
