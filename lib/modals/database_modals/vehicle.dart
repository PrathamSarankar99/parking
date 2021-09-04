import 'package:parking/modals/others/vehicle_type.dart';

class Vehicle {
  final String id;
  final String user;
  final String number;
  final bool isPrimary;
  final String name;
  final VehicleType type;

  Vehicle({
    this.id,
    this.user,
    this.number,
    this.type,
    this.isPrimary,
    this.name,
  });
}

var dummyVehicles = [
  Vehicle(
    id: '1',
    name: 'Grand i10',
    number: 'MP-04-9351',
    type: VehicleType.car,
    user: 'pratham',
    isPrimary: true,
  ),
  Vehicle(
    id: '1',
    name: 'Avenger 220',
    number: 'MP-07-9826',
    type: VehicleType.bike,
    user: 'pratham',
    isPrimary: true,
  ),
  Vehicle(
    id: '1',
    name: 'Audi 800',
    number: 'DL-05-8231',
    type: VehicleType.car,
    user: 'pratham',
    isPrimary: false,
  ),
  Vehicle(
    id: '1',
    name: 'Pulsar 350',
    number: 'MH-04-8342',
    type: VehicleType.car,
    user: 'pratham',
    isPrimary: false,
  ),
  Vehicle(
    id: '1',
    name: 'Mercedes v60',
    number: 'KL-07-1936',
    type: VehicleType.car,
    user: 'pratham',
    isPrimary: false,
  ),
];
