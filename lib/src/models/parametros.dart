part 'paginacao.g.dart';

/// A class representing a set of parameters for a request.
///
/// This class contains information about a date range and pagination details.
///
/// The [Parametros] class has a constructor that requires the following parameters:
/// - [inicio]: the start date of the range.
/// - [fim]: the end date of the range.
/// - [paginacao]: a [Paginacao] object representing the pagination details.
class Parametros {
  final String inicio;
  final String fim;
  final Paginacao paginacao;

  Parametros({
    required this.inicio,
    required this.fim,
    required this.paginacao,
  });

  /// A factory method for creating a [Parametros] object from a JSON object.
  ///
  /// This method takes a [Map<String, dynamic>] object and returns a new instance of [Parametros] class.
  ///
  /// The following keys must be present in the input JSON object:
  /// - 'inicio': the start date of the range.
  /// - 'fim': the end date of the range.
  /// - 'paginacao': a [Map<String, dynamic>] object representing the pagination details.
  factory Parametros.fromJson(Map<String, dynamic> json) {
    return Parametros(
      inicio: json['inicio'],
      fim: json['fim'],
      paginacao: Paginacao.fromJson(json['paginacao']),
    );
  }

  /// A method for serializing the [Parametros] object to a JSON object.
  ///
  /// This method returns a [Map<String, dynamic>] object representing the [Parametros] object.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['inicio'] = inicio;
    data['fim'] = fim;
    data['paginacao'] = paginacao.toJson();
    return data;
  }
}
