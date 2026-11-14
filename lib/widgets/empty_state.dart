import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

/// Placeholder shown when the contacts list is empty (Lottie animation + text).
class EmptyState extends StatelessWidget {
  const EmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(
              'assets/lottie/empty_list.json',
              width: 260,
              height: 260,
              repeat: true,
            ),
            const SizedBox(height: 16),
            Text(
              'There is No Contacts Added Here',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
      ),
    );
  }
}
