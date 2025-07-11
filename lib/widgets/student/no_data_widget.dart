import 'package:flutter/material.dart';

class NoDataWidget extends StatelessWidget {
  final String message;
  const NoDataWidget({super.key, this.message = "Sorry! No data Available"});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // SvgPicture.asset(
          //   'assets/images/no_data.svg',
          //   width: double.infinity,
          //   height: 200,
          //   color: AppColors.mainColor.withOpacity(1),
          // ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              message,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }
}
