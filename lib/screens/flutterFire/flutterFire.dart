import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mynewapp/screens/flutterFire/flutterAuth.dart';
import 'package:mynewapp/screens/flutterFire/flutterProfile.dart';
import 'package:mynewapp/services/authentication_service.dart';

class FlutterFire extends ConsumerWidget {
  static const routeName = '/flutterFire';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // you can now listen for the stream within the instance
    return ref.watch(AuthenticationService.firebaseUserProvider).when(
          data: (userID) {
            if (userID == null) {
              return FlutterAuth();
            } else {
              return FlutterProfile();
            }
          },
          loading: () => const CircularProgressIndicator(
            strokeWidth: 2,
          ),
          error: (error, stack) => Text('Error : $error'),
        );
  }
}
