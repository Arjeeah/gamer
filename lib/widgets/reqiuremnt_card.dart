import 'package:anime_app/models/one_game_model.dart';
import 'package:anime_app/providers/dark_mode_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReqiuremntCard extends StatelessWidget {
  const ReqiuremntCard({super.key, required this.min});
  final MinimumSystemRequirements min;

  @override
  Widget build(BuildContext context) {
    return Consumer<DarkModeProvider>(builder: (context, darkmodeconsumer, _) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "MinimumSystemRequirements",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: darkmodeconsumer.isdark ? Colors.white : Colors.black54),
          ),
          Text(
            "OS ${min.os}",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: darkmodeconsumer.isdark ? Colors.white : Colors.black),
          ),
          Text(
            "Memory ${min.memory}",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: darkmodeconsumer.isdark ? Colors.white : Colors.black),
          ),
          Text(
            "Graphics ${min.graphics}",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: darkmodeconsumer.isdark ? Colors.white : Colors.black),
          ),
          Text(
            "Processor ${min.processor}",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: darkmodeconsumer.isdark ? Colors.white : Colors.black),
          ),
          Text(
            "Storage ${min.storage}",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: darkmodeconsumer.isdark ? Colors.white : Colors.black),
          ),
        ],
      );
    });
  }
}
