import 'package:flutter/material.dart';

import '../../data/models/fact_model.dart';


class FactTile extends StatelessWidget {
  final FactModel fact;

  const FactTile({super.key, required this.fact});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        title: Text(fact.fact),
        subtitle: Text("Category: ${fact.category}"),
      ),
    );
  }
}
