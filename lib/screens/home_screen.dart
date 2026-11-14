import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../models/contact.dart';
import '../widgets/add_contact_sheet.dart';
import '../widgets/contact_card.dart';
import '../widgets/empty_state.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /// When the user has 6 contacts the Add button is hidden.
  static const int maxContacts = 6;

  final List<Contact> _contacts = [];

  Future<void> _addContact() async {
    final contact = await AddContactSheet.show(context);
    if (contact == null) return;
    setState(() => _contacts.add(contact));
  }

  void _deleteAt(int index) => setState(() => _contacts.removeAt(index));

  void _deleteLast() {
    if (_contacts.isEmpty) return;
    setState(() => _contacts.removeLast());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              // Route logo as the app bar
              Image.asset('assets/images/route_logo.png', height: 40),
              const SizedBox(height: 16),
              Expanded(
                child: _contacts.isEmpty
                    ? const EmptyState()
                    : GridView.builder(
                        padding: const EdgeInsets.only(bottom: 150),
                        itemCount: _contacts.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          mainAxisExtent: 320,
                        ),
                        itemBuilder: (context, index) => ContactCard(
                          contact: _contacts[index],
                          onDelete: () => _deleteAt(index),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Delete last item : visible only if there are contacts
          if (_contacts.isNotEmpty)
            FloatingActionButton(
              heroTag: 'delete_fab',
              onPressed: _deleteLast,
              backgroundColor: AppColors.red,
              foregroundColor: AppColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(Icons.delete_rounded),
            ),
          if (_contacts.isNotEmpty && _contacts.length < maxContacts)
            const SizedBox(height: 12),
          // Add : invisible once the user has 6 contacts
          if (_contacts.length < maxContacts)
            FloatingActionButton(
              heroTag: 'add_fab',
              onPressed: _addContact,
              backgroundColor: AppColors.gold,
              foregroundColor: AppColors.darkBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(Icons.add),
            ),
        ],
      ),
    );
  }
}
