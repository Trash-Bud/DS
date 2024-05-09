import 'dart:ui';

import 'package:design_system/design_system.dart';

enum PoStatus {
  open,
  inProgress,
  archived,
  cancelled,
  unknown;

  @override
  String toString() {
    switch (this) {
      case PoStatus.open:
        return 'Open';
      case PoStatus.inProgress:
        return 'In Progress';
      case PoStatus.archived:
        return 'Archived';
      case PoStatus.cancelled:
        return 'Cancelled';
      case PoStatus.unknown:
        return 'Unknown';
      default:
        return 'Unknown';
    }
  }

  static const Map<PoStatus, Color> poStatusColor = {
    PoStatus.open: openPo,
    PoStatus.inProgress: inProgressPo ,
    PoStatus.archived: archivedPo ,
    PoStatus.cancelled: cancelledPo ,
    PoStatus.unknown: unknownStatus,
  };

}
