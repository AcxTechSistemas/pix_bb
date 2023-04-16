// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:pix_bb/src/errors/pix_exception.dart';

/// Exception to represent a date-related error.
class BBDateException implements PixException {
  final String _error;
  final DateTime _initialDate;
  final DateTime _finalDate;
  final int _difference;

  BBDateException({
    required String error,
    required DateTime initialDate,
    required DateTime finalDate,
    required int difference,
  })  : _error = error,
        _initialDate = initialDate,
        _finalDate = finalDate,
        _difference = difference;

  /// The error message returned by the API.
  @override
  String get error => _error;

  /// Gets the information of this exception.
  @override
  String get errorDescription => toString();

  /// Exception to represent a date-range-start.
  DateTime get initialDate => _initialDate;

  /// Exception to represent a date-range-end.
  DateTime get finalDate => _finalDate;

  /// Exception to represent a date-range-difference-in-days.
  int get difference => _difference;

  /// Factory method for creating an instance of [BBHttpException].
  ///
  /// [exception] is the underlying exception that caused the HTTP request to fail.
  static PixException differenceBetweenDatesTooLong(
    DateTimeRange dateTimeRange,
  ) {
    return BBDateException(
      error: 'difference-between-dates-too-long',
      initialDate: dateTimeRange.start,
      finalDate: dateTimeRange.end,
      difference: dateTimeRange.duration.inDays,
    );
  }

  /// Returns a string representation of this exception.

  @override
  String toString() {
    return 'BBDateException: error: $error,initialDate: $initialDate,finalDate: $finalDate,difference: $difference days';
  }
}
