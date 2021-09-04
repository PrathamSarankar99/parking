import 'package:geocoding/geocoding.dart';

class Address {
  final String street;
  final String isoCode;
  final String country;
  final String postalCode;
  final String state;
  final String city;
  final String locality;
  final String subLocality;

  Address({
    this.street,
    this.isoCode,
    this.country,
    this.postalCode,
    this.state,
    this.city,
    this.locality,
    this.subLocality,
  });

  static fromPlaceMark(Placemark placemark) {
    return Address(
      city: placemark.subAdministrativeArea,
      country: placemark.country,
      isoCode: placemark.isoCountryCode,
      locality: placemark.locality,
      postalCode: placemark.postalCode,
      state: placemark.administrativeArea,
      street: placemark.street,
      subLocality: placemark.subLocality,
    );
  }
}
