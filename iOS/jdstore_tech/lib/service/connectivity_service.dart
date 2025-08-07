import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConnectivityService extends GetxService {
  late StreamSubscription<List<ConnectivityResult>> _subscription;

  @override
  void onInit() {
    super.onInit();
    _subscription =
        Connectivity().onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void _updateConnectionStatus(List<ConnectivityResult> results) {
    final hasConnection = results.any((r) => r != ConnectivityResult.none);

    if (!hasConnection) {
      if (!(Get.isDialogOpen ?? false)) {
        Get.dialog(
          AlertDialog(
            title: Text("No Internet"),
            content: Text("Please check your internet connection."),
            actions: [
              TextButton(
                child: Text("Retry"),
                onPressed: () async {
                  final current = await Connectivity().checkConnectivity();
                  print(current);
                  if (current[0] != ConnectivityResult.none) {
                    Get.back();
                  }
                },
              )
            ],
          ),
          barrierDismissible: false,
        );
      }
    } else {
      if (Get.isDialogOpen ?? false) Get.back();
    }
  }

  @override
  void onClose() {
    _subscription.cancel();
    super.onClose();
  }
}
