import 'package:flutter/material.dart';
import 'package:beauty_salon/features/calendar/models/calendar_schedule_model.dart';

class AppointmentCard extends StatelessWidget {
  final CalendarScheduleModel item;
  final VoidCallback? onDelete;
  final VoidCallback? onUpdate;

  const AppointmentCard({
    super.key,
    required this.item,
    this.onDelete,
    this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    const mint = Color(0xFFAEC6C1);
    const grayText = Colors.black54;

    return GestureDetector(
      onTap: () => _showActionDialog(context),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: mint.withOpacity(0.3)),
          boxShadow: [
            BoxShadow(
              color: mint.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.timeFrom,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.timeTo,
                  style: const TextStyle(color: grayText, fontSize: 13),
                ),
              ],
            ),
            const SizedBox(width: 16),
            Container(
              width: 4,
              height: 45,
              decoration: BoxDecoration(
                color: mint,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.clientName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    item.service,
                    style: const TextStyle(fontSize: 14, color: grayText),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    item.staffName,
                    style: const TextStyle(color: grayText, fontSize: 13),
                  ),
                ],
              ),
            ),
            const Icon(Icons.more_vert, color: Colors.black45),
          ],
        ),
      ),
    );
  }

  void _showActionDialog(BuildContext context) {
    const grayText = Colors.black54;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: Colors.white,
        title: const Text(
          "Manage Appointment",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        content: const Text(
          "What would you like to do?",
          style: TextStyle(color: grayText, fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              if (onUpdate != null) onUpdate!();
            },
            child: const Text(
              "Update",
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              if (onDelete != null) onDelete!();
            },
            child: const Text(
              "Delete",
              style: TextStyle(
                color: Colors.redAccent,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "Cancel",
              style: TextStyle(color: grayText, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
