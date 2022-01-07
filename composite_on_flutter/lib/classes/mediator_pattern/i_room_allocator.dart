import 'package:composite_on_flutter/classes/mediator_pattern/room.dart';

abstract class IRoomAllocator {
  void allocateRoom(Room room);
  void setAvailabilityStatus(bool status);
  bool isAvailable();
}
