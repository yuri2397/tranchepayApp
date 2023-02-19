import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KeyboardWidget extends StatelessWidget {
  Function keyTap;
  KeyboardWidget({super.key, required this.keyTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () => keyTap('1'),
                  child: Text(
                    '1',
                    style: Get.textTheme.displayMedium?.merge(
                        const TextStyle(fontSize: 30, fontFamily: 'Poppins')),
                  ),
                ),
              ),
              Expanded(
                child: TextButton(
                  onPressed: () => keyTap('2'),
                  child: Text(
                    '2',
                    style: Get.textTheme.displayMedium?.merge(
                        const TextStyle(fontSize: 30, fontFamily: 'Poppins')),
                  ),
                ),
              ),
              Expanded(
                child: TextButton(
                  onPressed: () => keyTap('3'),
                  child: Text(
                    '3',
                    style: Get.textTheme.displayMedium?.merge(
                        const TextStyle(fontSize: 30, fontFamily: 'Poppins')),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () => keyTap('4'),
                  child: Text(
                    '4',
                    style: Get.textTheme.displayMedium?.merge(
                        const TextStyle(fontSize: 30, fontFamily: 'Poppins')),
                  ),
                ),
              ),
              Expanded(
                child: TextButton(
                  onPressed: () => keyTap('5'),
                  child: Text(
                    '5',
                    style: Get.textTheme.displayMedium?.merge(
                        const TextStyle(fontSize: 30, fontFamily: 'Poppins')),
                  ),
                ),
              ),
              Expanded(
                child: TextButton(
                  onPressed: () => keyTap('6'),
                  child: Text(
                    '6',
                    style: Get.textTheme.displayMedium?.merge(
                        const TextStyle(fontSize: 30, fontFamily: 'Poppins')),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () => keyTap('7'),
                  child: Text(
                    '7',
                    style: Get.textTheme.displayMedium?.merge(
                        const TextStyle(fontSize: 30, fontFamily: 'Poppins')),
                  ),
                ),
              ),
              Expanded(
                child: TextButton(
                  onPressed: () => keyTap('8'),
                  child: Text(
                    '8',
                    style: Get.textTheme.displayMedium?.merge(
                        const TextStyle(fontSize: 30, fontFamily: 'Poppins')),
                  ),
                ),
              ),
              Expanded(
                child: TextButton(
                  onPressed: () => keyTap('9'),
                  child: Text(
                    '9',
                    style: Get.textTheme.displayMedium?.merge(
                        const TextStyle(fontSize: 30, fontFamily: 'Poppins')),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: null,
                  child: Text(
                    '',
                    style: Get.textTheme.displayMedium?.merge(
                        const TextStyle(fontSize: 30, fontFamily: 'Poppins')),
                  ),
                ),
              ),
              Expanded(
                child: TextButton(
                  onPressed: () => keyTap('0'),
                  child: Text(
                    '0',
                    style: Get.textTheme.displayMedium?.merge(
                        const TextStyle(fontSize: 30, fontFamily: 'Poppins')),
                  ),
                ),
              ),
              Expanded(
                child: TextButton(
                  onPressed: () => keyTap('delete'),
                  child: const Icon(
                    Icons.backspace_rounded,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
