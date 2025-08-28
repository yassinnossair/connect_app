// lib/src/presentation/pages/scan_page.dart

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide ConnectionState;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:connect/src/domain/repositories/auth_repository.dart';
import 'package:connect/src/domain/repositories/connection_repository.dart';
import 'package:connect/src/presentation/bloc/connection/connection_bloc.dart';
import 'package:connect/src/presentation/bloc/connection/connection_event.dart';
import 'package:connect/src/presentation/bloc/connection/connection_state.dart';
import 'package:connect/src/presentation/bloc/profile/profile_bloc.dart';

class ScanPage extends StatelessWidget {
  const ScanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ConnectionBloc(
        connectionRepository: RepositoryProvider.of<ConnectionRepository>(
          context,
        ),
        profileBloc: context.read<ProfileBloc>(),
        authRepository: RepositoryProvider.of<AuthRepository>(context),
      ),
      child: const ScanView(),
    );
  }
}

class ScanView extends StatefulWidget {
  const ScanView({super.key});

  @override
  State<ScanView> createState() => _ScanViewState();
}

class _ScanViewState extends State<ScanView> {
  final MobileScannerController cameraController = MobileScannerController();
  bool isScanProcessing = false;
  String? _lastScannedUserId;

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  String? _extractUserIdFromUrl(String url) {
    const prefix = 'https://connect-final-199ec.web.app/p/';
    if (url.startsWith(prefix)) {
      return url.substring(prefix.length);
    }
    return null;
  }

  void _handleScan(String scannedData) {
    if (isScanProcessing) return;
    final scannedUserId = _extractUserIdFromUrl(scannedData);
    if (scannedUserId != null && scannedUserId == _lastScannedUserId) {
      return;
    }
    setState(() {
      isScanProcessing = true;
    });
    if (scannedUserId != null) {
      _lastScannedUserId = scannedUserId;
      context.read<ConnectionBloc>().add(
        ConnectionRequestSent(targetUserId: scannedUserId),
      );
    } else {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text('Invalid QR Code. Please scan a ConnectSphere code.'),
            backgroundColor: Colors.red,
          ),
        );
    }
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          isScanProcessing = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ConnectionBloc, ConnectionState>(
      listener: (context, state) {
        if (state.status == ConnectionStatus.success) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text('Connection request sent successfully!'),
                backgroundColor: Colors.green,
              ),
            );
        } else if (state.status == ConnectionStatus.failure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(
                  'Error: ${state.errorMessage ?? 'Could not send request.'}',
                ),
                backgroundColor: Colors.red,
              ),
            );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Scan to Connect'),
          actions: [
            IconButton(
              color: Colors.white,
              icon: ValueListenableBuilder(
                valueListenable: cameraController,
                builder: (context, state, child) {
                  return Icon(
                    state.torchState == TorchState.on
                        ? Icons.flash_on
                        : Icons.flash_off,
                  );
                },
              ),
              onPressed: () => cameraController.toggleTorch(),
            ),
          ],
        ),
        body: Stack(
          children: [
            MobileScanner(
              controller: cameraController,
              onDetect: (capture) {
                final barcode = capture.barcodes.firstOrNull;
                if (barcode?.rawValue != null) {
                  _handleScan(barcode!.rawValue!);
                }
              },
            ),
            _buildScannerOverlay(context),
          ],
        ),
      ),
    );
  }

  Widget _buildScannerOverlay(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Align QR code within the frame',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            height: 250,
            width: 250,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 4),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          const SizedBox(height: 20),
          if (kDebugMode)
            ElevatedButton(
              onPressed: () {
                const testUrl =
                    'https://connect-final-199ec.web.app/p/pU4fVM6oxlf2ZGpGkB7yWAFnRmG3';
                _handleScan(testUrl);
              },
              child: const Text('Simulate Scan (For Dev)'),
            ),
        ],
      ),
    );
  }
}
