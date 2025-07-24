import 'dart:developer';
import 'package:all_star_learning/Utils/custom_methods.dart';
import 'package:all_star_learning/new/features/qr/presentation/cubit/qr_cubit.dart';
import 'package:all_star_learning/new/features/qr/presentation/cubit/qr_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

class QrView extends StatefulWidget {
  const QrView({super.key});

  @override
  State<QrView> createState() => _QrViewState();
}

class _QrViewState extends State<QrView> {
  Barcode? _barcode;
  bool _isScanning = false;
  bool _hasPermission = false;
  bool _isInitializing = false;
  MobileScannerController? _controller;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    BlocProvider.of<QrCubit>(context).getScanTypes(
      report: false,
    );
  }

  Future<bool> _requestCameraPermission() async {
    try {
      final permission = Permission.camera;

      if (await permission.isGranted) {
        return true;
      }

      final result = await permission.request();
      return result == PermissionStatus.granted;
    } catch (e) {
      log("Error requesting camera permission: $e");
      return false;
    }
  }

  Future<void> _initializeCamera() async {
    if (_isInitializing) return;

    setState(() {
      _isInitializing = true;
    });

    try {
      final hasPermission = await _requestCameraPermission();

      if (hasPermission) {
        setState(() {
          _hasPermission = true;
          _controller = MobileScannerController(
            detectionSpeed: DetectionSpeed.noDuplicates,
          );
        });
      } else {
        setState(() {
          _hasPermission = false;
        });

        if (mounted) {
          _showPermissionDialog();
        }
      }
    } catch (e) {
      log("Error initializing camera: $e");
      if (mounted) {
        CustomMethods().showSnackBar(
          context,
          "Failed to initialize camera. Please try again.",
          Colors.red,
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isInitializing = false;
        });
      }
    }
  }

  void _showPermissionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Camera Permission Required'),
          content: const Text(
            'This app needs camera access to scan QR codes. Please grant camera permission to continue.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Optionally navigate back if camera is essential
                // Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await openAppSettings();
                // Re-check permission when user returns from settings
                Future.delayed(const Duration(seconds: 1), () {
                  if (mounted) {
                    _initializeCamera();
                  }
                });
              },
              child: const Text('Open Settings'),
            ),
          ],
        );
      },
    );
  }

  void _handleBarcode(BarcodeCapture barcodes) async {
    if (!_isScanning || !_hasPermission) return;

    final barcode = barcodes.barcodes.firstOrNull;
    if (barcode == null || barcode.rawValue == null) return;

    if (mounted) {
      setState(() {
        _barcode = barcode;
      });

      try {
        await BlocProvider.of<QrCubit>(context).scanQr(
          userID: barcode.rawValue!,
          onSuccess: () {
            if (mounted) {
              setState(() {
                _isScanning = false;
              });
              _controller?.stop();
            }
          },
          onError: (error) {
            if (mounted) {
              setState(() {
                _isScanning = false;
              });
              _controller?.stop();
            }
          },
        );
      } catch (e) {
        log("Error processing QR scan: $e");
        if (mounted) {
          setState(() {
            _isScanning = false;
          });
          _controller?.stop();
          CustomMethods().showSnackBar(
            context,
            "Failed to process QR code. Please try again.",
            Colors.red,
          );
        }
      }
    }
  }

  void _toggleScanning() {
    if (!_hasPermission) {
      _initializeCamera();
      return;
    }

    if (_controller == null) {
      CustomMethods().showSnackBar(
        context,
        "Camera not ready. Please wait or restart the app.",
        Colors.red,
      );
      return;
    }

    setState(() {
      _isScanning = !_isScanning;
    });

    try {
      if (_isScanning) {
        _controller?.start();
      } else {
        _controller?.stop();
      }
    } catch (e) {
      log("Error toggling scanner: $e");
      if (mounted) {
        setState(() {
          _isScanning = false;
        });
        CustomMethods().showSnackBar(
          context,
          "Camera error. Please restart the app.",
          Colors.red,
        );
      }
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QrCubit, QrState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('QR Code Attendance'),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 4,
                ),
                child: BlocBuilder<QrCubit, QrState>(
                  builder: (context, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Select Type",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                        SizedBox(height: 12.h),
                        DropdownButtonFormField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.shade300,
                            enabled: true,
                            border: const OutlineInputBorder(),
                          ),
                          value: state.selectedType,
                          items: state.scanTypesEntity
                              ?.map(
                                (e) => DropdownMenuItem(
                                  value: e.slug,
                                  child: Text(e.name ?? "N/A"),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            BlocProvider.of<QrCubit>(context).selectType(value);
                            setState(() {
                              _isScanning = false;
                              _barcode = null;
                            });
                            _controller?.stop();
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.all(12.sp),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                    style: BorderStyle.solid,
                  ),
                ),
                width: double.infinity,
                height: 0.54.sh,
                child: Column(
                  children: [
                    // Camera Preview
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        margin: EdgeInsets.all(16.sp),
                        color: Colors.black,
                        width: 1.sw,
                        height: 0.4.sh,
                        child: _buildCameraPreview(),
                      ),
                    ),
                    // Start/Stop Scan Button
                    ElevatedButton(
                      onPressed: () {
                        if (state.selectedType == null) {
                          CustomMethods().showSnackBar(
                            context,
                            "Please select type",
                            Colors.red,
                          );
                          return;
                        }

                        _toggleScanning();
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          vertical: 16.sp,
                          horizontal: 32.sp,
                        ),
                        backgroundColor: _isScanning
                            ? Theme.of(context).primaryColor
                            : Colors.green,
                      ),
                      child: _isInitializing
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : Text(
                              _getButtonText(),
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ],
                ),
              ),
              _buildScanResult(state),
              // Scan Result Details
              if (_barcode != null && state.scanStudentResponseEntity != null)
                Padding(
                  padding: EdgeInsets.all(12.sp),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "${state.scanStudentResponseEntity?.name ?? "N/A"} :",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 8.sp),
                          Expanded(
                            child: Text(
                              "${state.scanStudentResponseEntity?.classEntity?.name ?? "N/A"} - ${state.scanStudentResponseEntity?.section?.name ?? "N/A"} - ${state.scanStudentResponseEntity?.rollNo ?? "N/A"}",
                              style: TextStyle(
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Attendance Type :",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 8.sp),
                          Text(
                            state.selectedType ?? "N/A",
                            style: TextStyle(
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCameraPreview() {
    if (_isInitializing) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: Colors.white),
            SizedBox(height: 16),
            Text(
              'Initializing camera...',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),
          ],
        ),
      );
    }

    if (!_hasPermission) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.camera_alt_outlined,
              size: 64,
              color: Colors.white54,
            ),
            const SizedBox(height: 16),
            const Text(
              'Camera permission required',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _initializeCamera,
              child: const Text('Grant Permission'),
            ),
          ],
        ),
      );
    }

    if (_controller == null) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.white54,
            ),
            SizedBox(height: 16),
            Text(
              'Camera failed to initialize',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),
          ],
        ),
      );
    }

    return MobileScanner(
      controller: _controller,
      onDetect: _handleBarcode,
    );
  }

  Widget _buildScanResult(QrState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (!state.isLoading && state.error == null)
          Text(
            "Scan Result",
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        SizedBox(width: 16.sp),
        if (!state.isLoading && state.scanSuccess)
          Text(
            "Success",
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
        if (!state.isLoading && state.error != null)
          Expanded(
            child: Text(
              "Error: ${state.error?.message ?? "Not Assigned"}",
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
              textAlign: TextAlign.center,
            ),
          ),
      ],
    );
  }

  String _getButtonText() {
    if (!_hasPermission) {
      return "Grant Camera Permission";
    }
    if (_controller == null) {
      return "Camera Error - Restart App";
    }
    return _isScanning ? "Stop Scanning" : "Start Scanning";
  }
}
