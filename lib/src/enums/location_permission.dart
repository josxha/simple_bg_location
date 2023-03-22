/// Represent the possible location permissions.
///
/// |  value         |  description
/// |----------------|----------------------|
/// |-denied         | permission is denied |
/// |-deniedForever  | this value is only return by requestPermission.
/// |-whileInUse     | allowed only while the App is in use
/// |-always         | allowed even when the App is running in the background
/// |-unableToDetermine| program internal wrong
enum LocationPermission {
  /// Permission to access the device's location is denied, the App should try
  /// to request permission using the `SimpleBgLocation.requestPermission()` method.
  denied,

  /// Permission to access the device's location is permanently denied. When
  /// requesting permissions the permission dialog will not been shown until
  /// the user updates the permission in the App settings.
  deniedForever,

  /// Permission to access the device's location is allowed only while
  /// the App is in use.
  whileInUse,

  /// Permission to access the device's location is allowed even when the
  /// App is running in the background.
  always,

  /// Permission status is cannot be determined.
  unableToDetermine
}
