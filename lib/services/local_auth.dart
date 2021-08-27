import 'package:local_auth/local_auth.dart';

class LocalAuth {
  static Future<bool> isBiometricSupported() async {
    final LocalAuthentication localAuthentication = LocalAuthentication();
    return localAuthentication.isDeviceSupported();
  }

  static Future<bool> authenticateWithBiometrics() async {
    final LocalAuthentication localAuthentication = LocalAuthentication();
    // bool isBiometricSupported = await localAuthentication.isDeviceSupported();
    bool canCheckBiometrics = await localAuthentication.canCheckBiometrics;

    bool isAuthenticated = false;

    if (canCheckBiometrics) {
      isAuthenticated = await localAuthentication.authenticate(
        localizedReason: 'Please complete the biometrics to proceed.',
        biometricOnly: true,
      );
    }

    return isAuthenticated;
  }
}
