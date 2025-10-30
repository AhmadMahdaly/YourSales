import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

part 'location_permission_state.dart';

class LocationPermissionCubit extends Cubit<LocationPermissionState> {
  LocationPermissionCubit() : super(LocationPermissionInitial());

  Future<void> checkInitialPermission() async {
    emit(LocationPermissionLoading());

    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      emit(LocationPermissionServiceDisabled());
      return;
    }

    final status = await Permission.location.status;

    if (status.isGranted) {
      emit(LocationPermissionGranted());
    } else if (status.isPermanentlyDenied) {
      emit(LocationPermissionPermanentlyDenied());
    } else {
      emit(LocationPermissionDenied());
    }
  }

  Future<void> requestPermission() async {
    emit(LocationPermissionLoading());

    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      emit(LocationPermissionServiceDisabled());
      return;
    }

    final status = await Permission.location.request();

    if (status.isGranted) {
      emit(LocationPermissionGranted());
    } else if (status.isPermanentlyDenied) {
      emit(LocationPermissionPermanentlyDenied());
    } else {
      emit(LocationPermissionDenied());
    }
  }

  Future<void> openAppSettings() async {
    await openAppSettings();
  }
}
