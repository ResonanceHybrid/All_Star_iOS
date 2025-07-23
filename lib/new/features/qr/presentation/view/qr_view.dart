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
  MobileScannerController? _controller;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    BlocProvider.of<QrCubit>(context).getScanTypes(
      report: false,
    );
  }

  Future<void> _initializeCamera() async {
    // Request camera permission explicitly
    final permission = await Permission.camera.request();

    if (permission.isGranted) {
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
  }

  void _showPermissionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Camera Permission Required'),
          content: const Text(
            'This app needs camera access to scan QR codes. Please grant camera permission in Settings.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                openAppSettings();
              },
              child: const Text('Settings'),
            ),
          ],
        );
      },
    );
  }

  void _handleBarcode(BarcodeCapture barcodes) async {
    if (!_isScanning) return;

    final barcode = barcodes.barcodes.firstOrNull;
    if (barcode == null) return;

    if (mounted) {
      setState(() {
        _barcode = barcode;
      });

      await BlocProvider.of<QrCubit>(context).scanQr(
        userID: barcode.rawValue ?? "",
        onSuccess: () {
          setState(() {
            _isScanning = false;
          });
        },
        onError: (error) {
          setState(() {
            _isScanning = false;
          });
        },
      );
    }
  }

  void _toggleScanning() {
    if (!_hasPermission) {
      _initializeCamera();
      return;
    }

    setState(() {
      _isScanning = !_isScanning;
    });

    if (_isScanning) {
      _controller?.start();
    } else {
      _controller?.stop();
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
            title: const Text('Qr Code Attendance'),
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
                        child: _hasPermission && _controller != null
                            ? MobileScanner(
                                controller: _controller,
                                onDetect: _handleBarcode,
                              )
                            : Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.camera_alt_outlined,
                                      size: 64,
                                      color: Colors.white54,
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      _hasPermission
                                          ? 'Loading camera...'
                                          : 'Camera permission required',
                                      style: const TextStyle(
                                        color: Colors.white70,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
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
                      child: Text(
                        !_hasPermission
                            ? "Grant Camera Permission"
                            : (_isScanning
                                ? "Stop Scanning"
                                : "Start Scanning"),
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  !(!state.isLoading && state.error != null)
                      ? Text(
                          "Scan Result",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : const SizedBox.shrink(),
                  SizedBox(width: 16.sp),
                  (!state.isLoading && state.scanSuccess)
                      ? Text(
                          "Success",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : const SizedBox.shrink(),
                  (!state.isLoading && state.error != null)
                      ? Text(
                          "Error: ${state.error?.message ?? "Not Assigned"}",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
              // Scan Result
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
                          Text(
                            "${state.scanStudentResponseEntity?.classEntity?.name ?? "N/A"} - ${state.scanStudentResponseEntity?.section?.name ?? "N/A"} - ${state.scanStudentResponseEntity?.rollNo ?? "N/A"}",
                            style: TextStyle(
                              fontSize: 14.sp,
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
}
