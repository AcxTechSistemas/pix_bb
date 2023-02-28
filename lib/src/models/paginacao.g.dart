part of 'parametros.dart';

/// A class representing pagination information.
class Paginacao {
  /// The current page number.
  final int paginaAtual;

  /// The number of items per page.
  final int itensPorPagina;

  /// The total number of pages.
  final int quantidadeDePaginas;

  /// The total number of items.
  final int quantidadeTotalDeItens;

  /// Creates a new instance of [Paginacao].
  ///
  /// The [Paginacao] constructor requires the following parameters:
  ///
  /// - [paginaAtual]: the current page number.
  /// - [itensPorPagina]: the number of items per page.
  /// - [quantidadeDePaginas]: the total number of pages.
  /// - [quantidadeTotalDeItens]: the total number of items.
  Paginacao({
    required this.paginaAtual,
    required this.itensPorPagina,
    required this.quantidadeDePaginas,
    required this.quantidadeTotalDeItens,
  });

  /// Creates a new instance of [Paginacao] from a JSON object.
  ///
  /// The [Paginacao.fromJson] method requires a [Map<String, dynamic>] object representing
  /// the JSON object that will be used to create a new instance of [Paginacao].
  ///
  /// The keys of the [Map] must match the names of the parameters of the [Paginacao] constructor.
  factory Paginacao.fromJson(Map<String, dynamic> json) {
    return Paginacao(
      paginaAtual: json['paginaAtual'],
      itensPorPagina: json['itensPorPagina'],
      quantidadeDePaginas: json['quantidadeDePaginas'],
      quantidadeTotalDeItens: json['quantidadeTotalDeItens'],
    );
  }

  /// Serializes the [Paginacao] object to a JSON object.
  ///
  /// The [toJson] method returns a [Map<String, dynamic>] object representing
  /// the [Paginacao] object that will be used to create a new instance of [Paginacao].
  ///
  /// The keys of the [Map] must match the names of the parameters of the [Paginacao] constructor.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['paginaAtual'] = paginaAtual;
    data['itensPorPagina'] = itensPorPagina;
    data['quantidadeDePaginas'] = quantidadeDePaginas;
    data['quantidadeTotalDeItens'] = quantidadeTotalDeItens;
    return data;
  }
}
