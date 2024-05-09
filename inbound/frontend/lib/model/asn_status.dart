import 'package:flutter/material.dart';

enum ASNStatus {
  pending,
  booked,
  received,
  cancelled,
  unknown;

  @override
  String toString() {
    switch (this) {
      case ASNStatus.pending:
        return 'Pending';
      case ASNStatus.booked:
        return 'Booked';
      case ASNStatus.received:
        return 'Received';
      case ASNStatus.cancelled:
        return 'Cancelled';
      default:
        return 'Unknown';
    }
  }

  static const Map<ASNStatus, Color> asnStatusColor = {
    ASNStatus.pending: Colors.yellow,
    ASNStatus.booked: Colors.lightBlueAccent,
    ASNStatus.received: Colors.green,
    ASNStatus.cancelled: Colors.red,
    ASNStatus.unknown: Colors.grey,
  };

}