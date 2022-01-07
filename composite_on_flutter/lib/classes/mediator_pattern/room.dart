import 'package:composite_on_flutter/classes/mediator_pattern/i_room_allocator.dart';

class Room {
  late IRoomAllocator _roomAllocatorMediater;
  Room(IRoomAllocator ira) {
    _roomAllocatorMediater = ira;
  }
  bool bookTheRoom() {
    // print('Room is available for booking');
    if (_roomAllocatorMediater.isAvailable()) {
      print('Room Booked');
      _roomAllocatorMediater.setAvailabilityStatus(false);
      return true;
    } else {
      return false;
    }
  }

  void freeTheRom() {
    print('Room unbooked');
    _roomAllocatorMediater.setAvailabilityStatus(true);
  }
}
