part of 'location_permission_cubit.dart';

@immutable
abstract class LocationPermissionState {}

class LocationPermissionInitial extends LocationPermissionState {}

class LocationPermissionLoading extends LocationPermissionState {}

class LocationPermissionGranted extends LocationPermissionState {}

class LocationPermissionDenied extends LocationPermissionState {}

class LocationPermissionPermanentlyDenied extends LocationPermissionState {}

class LocationPermissionServiceDisabled extends LocationPermissionState {}
