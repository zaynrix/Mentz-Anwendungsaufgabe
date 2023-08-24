import 'package:flutter/material.dart';
import 'package:mentz_task/features/models/locations_model.dart';
import 'package:mentz_task/resources/color_manager.dart';

class DetailsWidget extends StatelessWidget {
  final Locations location;

  const DetailsWidget({Key? key, required this.location}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: [
          RowDetails("Disassembled Name",
              location.disassembledName ?? "No Disassembled Name"),
          const SizedBox(height: 10),
          RowDetails("ID", location.id ?? "No ID"),
          const SizedBox(height: 5),
          RowDetails("Parent Name", location.parent?.name ?? "No Parent Name"),
          const SizedBox(height: 5),
          RowDetails("Parent Type", location.parent?.type ?? "No Parent Type"),
          const SizedBox(height: 5),
          RowDetails("Properties Stop Id",
              location.properties?.stopId ?? "No Stop ID"),
          const SizedBox(height: 5),
          RowDetails("Is Best", location.isBest ?? "No Defined"),
          const SizedBox(height: 5),
          RowDetails("Is Global Id", location.isGlobalId ?? "No Defined"),
          const SizedBox(height: 5),
          RowDetails("Match Quality", location.matchQuality ?? "No Defined"),
          const SizedBox(height: 5),
          RowDetails(
              "Product Classes Num.", "${location.productClasses?.length}"),
        ],
      ),
    );
  }

  Widget RowDetails(String label, value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            label,
            style: const TextStyle(color: ColorManager.borderGrey),
            overflow: TextOverflow.visible,
          ),
        ),
        Flexible(
          child: Text(
            "$value",
            textAlign: TextAlign.end,
            style: const TextStyle(color: ColorManager.white),
            overflow: TextOverflow.visible,
          ),
        ),
      ],
    );
  }
}
