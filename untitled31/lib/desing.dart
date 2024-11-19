import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BesinDeger extends StatelessWidget {
  final String makro;
  final int deger;
  const BesinDeger({super.key, required this.makro, required this.deger});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 135, // Genişliği biraz artırdık
      height: 100,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12), // Paddingi azalttık
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.purple.shade200, Colors.purple.shade400],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 8,
            color: Colors.black.withOpacity(0.1),
            offset: Offset(0, 4), // Yumuşak gölge
          ),
        ],
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Elemanlar arasındaki alanı eşit yapar
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                makro,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                deger.toString(),
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Icon(
            Icons.fastfood,  // Yiyecek simgesi, şık bir ikon
            color: Colors.white,
            size: 22, // İkon boyutunu biraz küçülttük
          ),
        ],
      ),
    );
  }
}