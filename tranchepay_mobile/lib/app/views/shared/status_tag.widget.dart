import 'package:flutter/material.dart';
import 'package:tranchepay_mobile/core/theme.colors.dart';

class StatusTag extends StatelessWidget {
  Status status;
  StatusTag({required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: statusColor(status),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        statusText(status),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Color statusColor(Status status) {
    switch (status) {
      case Status.pending:
        return Colors.orange;
      case Status.cancel:
        return Colors.red;
      case Status.success:
        return Colors.green;
      case Status.loading:
        return Color(mainColor);
    }
  }

  String statusText(Status status) {
    switch (status) {
      case Status.pending:
        return "En attente";
      case Status.cancel:
        return "Annulé";
      case Status.success:
        return "Terminé";
      case Status.loading:
        return "En cours";
    }
  }
}

enum Status { pending, cancel, success, loading }
