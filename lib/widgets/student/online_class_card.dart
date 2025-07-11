import 'package:flutter/material.dart';

class ZoomCard extends StatelessWidget {
  final Function() ontap;
  final Widget icon;
  final String title;
  final bool check;
  const ZoomCard(
      {super.key,
      required this.icon,
      required this.title,
      required this.check,
      required this.ontap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Column(
        children: [
          Container(
            width: 125,
            height: 165,
            margin:
                const EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 5),
            decoration: BoxDecoration(
                color: const Color(0xffFFFFF7),
                border: Border.all(
                    width: check == true ? 5 : 2,
                    color:
                        check == true ? const Color(0xfffe7d6a) : Colors.grey),
                borderRadius: const BorderRadius.all(Radius.circular(15))),
            child: SizedBox(
              height: 90,
              width: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: icon,
                  ),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
