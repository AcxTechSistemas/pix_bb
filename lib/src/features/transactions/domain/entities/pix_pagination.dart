import 'package:equatable/equatable.dart';

class PixPagination extends Equatable {
  final int paginaAtual;
  final int itensPorPagina;
  final int quantidadeDePaginas;
  final int quantidadeTotalDeItens;

  const PixPagination({
    required this.paginaAtual,
    required this.itensPorPagina,
    required this.quantidadeDePaginas,
    required this.quantidadeTotalDeItens,
  });

  @override
  List<Object?> get props => [
        paginaAtual,
        itensPorPagina,
        quantidadeDePaginas,
        quantidadeTotalDeItens,
      ];
}

class TransactionParams extends Equatable {
  final String inicio;
  final String fim;
  final PixPagination paginacao;

  const TransactionParams({
    required this.inicio,
    required this.fim,
    required this.paginacao,
  });

  @override
  List<Object?> get props => [inicio, fim, paginacao];
}
