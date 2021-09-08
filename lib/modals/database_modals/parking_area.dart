import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:parking/modals/others/address.dart';
import 'package:parking/modals/others/owner.dart';
import 'package:parking/utils/helpers/location_helper.dart';

class ParkingArea {
  final String id;
  final String name;
  final Address address;
  final GeoFirePoint location;
  final List<String> images;
  final Owner owner;
  final int charges;

  ParkingArea({
    @required this.id,
    @required this.location,
    @required this.owner,
    @required this.address,
    @required this.name,
    @required this.images,
    @required this.charges,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'street': address.street,
      'isoCode': address.isoCode,
      'country': address.country,
      'postalCode': address.postalCode,
      'state': address.state,
      'city': address.city,
      'locality': address.locality,
      'subLocality': address.subLocality,
      'location': location.data,
      'ownerName': owner.name,
      'ownerMail': owner.mailId,
      'images': images,
      'ownerContactNo': owner.contactNumber,
      'charges': charges,
    };
  }

  static ParkingArea fromMap(Map<String, dynamic> map, String id) {
    GeoFirePoint location = geoPointTogeoFirePoint(map['location']['geopoint']);
    Address address = Address(
      city: map['city'],
      country: map['country'],
      isoCode: map['isoCode'],
      locality: map['locality'],
      postalCode: map['postalCode'],
      state: map['state'],
      street: map['street'],
      subLocality: map['subLocality'],
    );

    Owner owner = Owner(
      contactNumber: map['ownerContactNo'],
      mailId: map['ownerMail'],
      name: map['ownerName'],
    );
    return ParkingArea(
      id: id,
      location: location,
      owner: owner,
      address: address,
      name: map['name'],
      charges: map['charges'],
      images: map['images'],
    );
  }

  static List<ParkingArea> documentsToAreaList(
      List<DocumentSnapshot<Map<String, dynamic>>> docs) {
    return docs.map((e) => ParkingArea.fromMap(e.data(), e.id)).toList();
  }

  Future<String> getFullAddress() async {
    List<Placemark> placeemarks =
        await placemarkFromCoordinates(location.latitude, location.longitude);
    Address a = Address.fromPlaceMark(placeemarks.first);
    return a.street +
        ', ' +
        a.subLocality +
        ', ' +
        a.city +
        ', ' +
        a.state +
        '.';
  }
}
