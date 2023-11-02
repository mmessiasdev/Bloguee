import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import '../model/locals.dart';


class MapController extends GetxController {
  var client = http.Client();
  List<Attributes> latitude = [];

  final lat = 0.0.obs;
  final long = 0.0.obs;

  LatLng _position = LatLng(-0, -0);
  GoogleMapController? _mapsController;

  static MapController get to => Get.find<MapController>();
  get mapsController => _mapsController;
  get position => _position;

  onMapCreated(GoogleMapController gmc) async {
    _mapsController = gmc;
    getPosition();
  }



  Future<Position> _currentPosition() async {
    LocationPermission permition;
    bool activate = await Geolocator.isLocationServiceEnabled();
    if (!activate) {
      return Future.error('Por favor, habilite a localização no smartphone.');
    }
    permition = await Geolocator.checkPermission();
    if (permition == LocationPermission.denied) {
      permition = await Geolocator.requestPermission();

      if (permition == LocationPermission.denied) {
        return Future.error('Você precisa autorizar o acesso à localização.');
      }
    }
    if (permition == LocationPermission.deniedForever) {
      return Future.error('Autorize o acesso à localização nas configurações.');
    }
    return await Geolocator.getCurrentPosition();
  }

  getPosition() async {
    try {
      final position = await _currentPosition();
      lat.value = position.latitude;
      long.value = position.longitude;
      _mapsController?.animateCamera(
          CameraUpdate.newLatLng(LatLng(lat.value, long.value)));
    } catch (e) {
      Get.snackbar(
        'Erro',
        e.toString(),
        backgroundColor: Colors.grey[900],
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}