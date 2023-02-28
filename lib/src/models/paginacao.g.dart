part of 'parametros.dart';

class Paginacao {
  final int paginaAtual;
  final int itensPorPagina;
  final int quantidadeDePaginas;
  final int quantidadeTotalDeItens;

  Paginacao({
    required this.paginaAtual,
    required this.itensPorPagina,
    required this.quantidadeDePaginas,
    required this.quantidadeTotalDeItens,
  });

  factory Paginacao.fromJson(Map<String, dynamic> json) {
    return Paginacao(
      paginaAtual: json['paginaAtual'],
      itensPorPagina: json['itensPorPagina'],
      quantidadeDePaginas: json['quantidadeDePaginas'],
      quantidadeTotalDeItens: json['quantidadeTotalDeItens'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['paginaAtual'] = paginaAtual;
    data['itensPorPagina'] = itensPorPagina;
    data['quantidadeDePaginas'] = quantidadeDePaginas;
    data['quantidadeTotalDeItens'] = quantidadeTotalDeItens;
    return data;
  }
}
