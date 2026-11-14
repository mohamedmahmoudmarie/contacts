import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../models/contact.dart';

/// Grid item: picked image with the name chip, email, phone and a Delete button.
class ContactCard extends StatelessWidget {
  final Contact contact;
  final VoidCallback onDelete;

  const ContactCard({
    super.key,
    required this.contact,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final bodySmall = Theme.of(context).textTheme.bodySmall!.copyWith(
          color: AppColors.darkBlue,
          fontSize: 11,
        );

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: ColoredBox(
        color: AppColors.gold,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // User image + name
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  contact.image != null
                      ? Image.memory(contact.image!, fit: BoxFit.cover)
                      : Container(
                          color: AppColors.darkBlue.withValues(alpha: 0.15),
                          padding: const EdgeInsets.all(28),
                          child: Image.asset(
                            'assets/images/image_placeholder.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                  Positioned(
                    left: 8,
                    bottom: 8,
                    right: 8,
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.gold,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          contact.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: AppColors.darkBlue,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Email + phone + delete
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _InfoLine(
                    icon: Icons.email_rounded,
                    text: contact.email,
                    style: bodySmall,
                  ),
                  const SizedBox(height: 6),
                  _InfoLine(
                    icon: Icons.phone_in_talk_rounded,
                    text: contact.phone,
                    style: bodySmall,
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton.icon(
                    onPressed: onDelete,
                    icon: const Icon(Icons.delete_rounded, size: 16),
                    label: const Text('Delete'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.red,
                      foregroundColor: AppColors.white,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      minimumSize: const Size.fromHeight(34),
                      textStyle: const TextStyle(fontSize: 13),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoLine extends StatelessWidget {
  final IconData icon;
  final String text;
  final TextStyle style;

  const _InfoLine({
    required this.icon,
    required this.text,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.darkBlue),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: style,
          ),
        ),
      ],
    );
  }
}
