enum VehicleType {
  car,
  bike,
}

int encodeVehicle(VehicleType type) {
  if (type == VehicleType.car) {
    return 0;
  } else {
    return 1;
  }
}

VehicleType decodeVehicle(int type) {
  if (type == 0) {
    return VehicleType.car;
  }
  return VehicleType.bike;
}
