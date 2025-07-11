import 'package:all_star_learning/Utils/custom_methods.dart';
import 'package:all_star_learning/new/features/qr/presentation/cubit/qr_cubit.dart';
import 'package:all_star_learning/new/features/qr/presentation/cubit/qr_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrView extends StatefulWidget {
  const QrView({super.key});

  @override
  State<QrView> createState() => _QrViewState();
}

class _QrViewState extends State<QrView> {
  Barcode? _barcode;

  bool _isScanning = false;

  void _handleBarcode(BarcodeCapture barcodes) async {
    if (!_isScanning) return;
    if (mounted) {
      setState(() {
        _barcode = barcodes.barcodes.firstOrNull;
      });
    }

    await BlocProvider.of<QrCubit>(context).scanQr(
        userID: _barcode?.rawValue ?? "",
        onSuccess: () {
          setState(() {
            _isScanning = false;
          });
          // Get.back();
        },
        onError: ((p0) {
          _isScanning = false;
        }));
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<QrCubit>(context).getScanTypes(
      report: false,
    );
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
                          items: state.scanTypesEntity!
                              .map(
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
                        child: MobileScanner(
                          onDetect: _handleBarcode,
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

                        if (_isScanning) {
                          setState(() {
                            _isScanning = false;
                          });
                        } else {
                          setState(() {
                            _isScanning = true;
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            vertical: 16.sp,
                            horizontal: 32.sp,
                          ),
                          backgroundColor: _isScanning
                              ? Theme.of(context).primaryColor
                              : Colors.green),
                      child: Text(
                        _isScanning ? "Stop Scanning" : "Start Scanning",
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
                      // ! TODO: Check if error is not null
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

                      //  Student Details
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
