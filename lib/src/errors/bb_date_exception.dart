// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:pix_bb/src/errors/pix_exception_interface.dart';

enum DateExceptionType {
  differenceBetweenDatesTooLong,
}

/// Exception to represent a date-related error.
class BBDateException implements PixException {
  final Map<String, dynamic> _error;
  final DateExceptionType _type;
  final DateTime _initialDate;
  final DateTime _finalDate;
  final int _difference;

  BBDateException({
    required Map<String, dynamic> error,
    required DateExceptionType type,
    required DateTime initialDate,
    required DateTime finalDate,
    required int difference,
  })  : _error = error,
        _type = type,
        _initialDate = initialDate,
        _finalDate = finalDate,
        _difference = difference;

  /// Exception to represent a date-related type.
  @override
  Enum get exceptionType => _type;

  /// Exception to represent a date-related error.
  @override
  Map<String, dynamic> get message => _error;

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
      error: {
        'error':
            'Difference between start date and end date cannot be greater than 4 day',
      },
      initialDate: dateTimeRange.start,
      finalDate: dateTimeRange.end,
      difference: dateTimeRange.duration.inDays,
      type: DateExceptionType.differenceBetweenDatesTooLong,
    );
  }

  /// Returns a string representation of this exception.

  @override
  String toString() {
    return '''
BBDateException:
  error: ${_error['error']},
  type: $_type,
  initialDate: $_initialDate,
  finalDate: $_finalDate,
  difference: $_difference days''';
  }
}
