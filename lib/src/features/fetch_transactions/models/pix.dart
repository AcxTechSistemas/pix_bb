// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

part 'pagador.g.dart';

///A class representing a PIX payment.
///
/// This class contains information aboute a payment made through PIX.
///
/// The [PIX] class has a constructor that requires the following parameters:
/// - [valor] the value of payment.
/// - [horario] the date and time when payment was made.
/// - [pagador]: a [Pagador] object representing the payer.
/// - [infoPagador] additional information about the payer.
///
/// - The [endToEndId] and [txid] parameters are optional, and can be set to null.
class Pix {
  /// A unique identifier for the payment.
  final String? endToEndId;

  /// A transaction ID for the payment.
  final String valor;

  /// The value of payment.
  final String horario;

  /// A [Map<String, dynamic>] object representing the payer.
  final Pagador pagador;

  /// Additional information about the payer.
  final String infoPagador;

  /// A transaction ID for the payment.
  final String? txid;

  Pix({
    this.endToEndId,
    required this.valor,
    required this.horario,
    required this.pagador,
    required this.infoPagador,
    this.txid,
  });

  /// Serializes the [PIX] object to a MAP object.
  ///
  /// The [toMap] method returns a [Map<String, dynamic>] object representing
  /// the [PIX] object that will be used to create a new instance of [PIX].
  ///
  /// The keys of the [Map] must match the names of the parameters of the [PIX] constructor.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'endToEndId': endToEndId,
      'valor': valor,
      'horario': horario,
      'pagador': pagador.toMap(),
      'infoPagador': infoPagador,
      'txid': txid,
    };
  }

  /// A factory method for creating a [PIX] object from a MAP object.
  factory Pix.fromMap(Map<String, dynamic> map) {
    return Pix(
      endToEndId:
          map['endToEndId'] != null ? map['endToEndId'] as String : null,
      valor: map['valor'] as String,
      horario: map['horario'] as String,
      pagador: Pagador.fromMap(map['pagador'] as Map<String, dynamic>),
      infoPagador: map['infoPagador'] as String,
      txid: map['txid'] != null ? map['txid'] as String : null,
    );
  }

  /// This method serializing the [PIX] object to JSON string
  String toJson() => json.encode(toMap());

  ///a factory method for creating a [PIX] object from a JSON object
  factory Pix.fromJson(String source) =>
      Pix.fromMap(json.decode(source) as Map<String, dynamic>);
}
