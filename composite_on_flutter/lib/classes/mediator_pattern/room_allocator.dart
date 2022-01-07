import 'package:composite_on_flutter/classes/mediator_pattern/i_room_allocator.dart';
import 'package:composite_on_flutter/classes/mediator_pattern/room.dart';

class RoomAllocator implements IRoomAllocator {
  late Room room;
  bool available = true;

  @override
  void allocateRoom(Room room) {
    this.room = room;
  }

  @override
  bool isAvailable() {
    return available;
  }

  @override
  void setAvailabilityStatus(bool status) {
    available = status;
  }
}
