import 'package:parking/modals/others/booking_status.dart';

class Booking {
  final String id;
  final String parkingId;
  final String userId;
  final String vehicleId;
  final String transactionId;
  final DateTime from;
  final DateTime till;
  final double charges;
  final BookingStatus status;
  Booking({
    this.id,
    this.parkingId,
    this.userId,
    this.vehicleId,
    this.transactionId,
    this.from,
    this.till,
    this.charges,
    this.status,
  });
}
