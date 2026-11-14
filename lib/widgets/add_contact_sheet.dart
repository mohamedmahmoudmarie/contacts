import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../core/app_colors.dart';
import '../models/contact.dart';
import 'app_text_field.dart';

/// Bottom sheet for adding one user.
/// Returns the new [Contact] via Navigator.pop when "Enter user" is pressed.
class AddContactSheet extends StatefulWidget {
  const AddContactSheet({super.key});

  static Future<Contact?> show(BuildContext context) {
    return showModalBottomSheet<Contact>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => const AddContactSheet(),
    );
  }

  @override
  State<AddContactSheet> createState() => _AddContactSheetState();
}

class _AddContactSheetState extends State<AddContactSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _picker = ImagePicker();
  Uint8List? _image;

  @override
  void initState() {
    super.initState();
    // Live preview: rebuild whenever the user types.
    for (final c in [_nameController, _emailController, _phoneController]) {
      c.addListener(_refresh);
    }
  }

  void _refresh() => setState(() {});

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final file = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1080,
      imageQuality: 85,
    );
    if (file == null) return;
    final bytes = await file.readAsBytes();
    if (!mounted) return;
    setState(() => _image = bytes);
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.of(context).pop(
      Contact(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        phone: _phoneController.text.trim(),
        image: _image,
      ),
    );
  }

  String? _required(String? v, String field) =>
      (v == null || v.trim().isEmpty) ? 'Please enter $field' : null;

  String? _validateEmail(String? v) {
    final error = _required(v, 'the email');
    if (error != null) return error;
    final regex = RegExp(r'^[\w.+-]+@[\w-]+\.[\w.-]+$');
    return regex.hasMatch(v!.trim()) ? null : 'Please enter a valid email';
  }

  String? _validatePhone(String? v) {
    final error = _required(v, 'the phone');
    if (error != null) return error;
    final regex = RegExp(r'^\+?[0-9]{8,15}$');
    return regex.hasMatch(v!.trim()) ? null : 'Please enter a valid phone';
  }

  @override
  Widget build(BuildContext context) {
    final keyboard = MediaQuery.viewInsetsOf(context).bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(16, 24, 16, 16 + keyboard),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Image picker + live preview of the user's input
              Row(
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      width: 120,
                      height: 120,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: AppColors.gold),
                      ),
                      child: _image != null
                          ? Image.memory(_image!, fit: BoxFit.cover)
                          : Padding(
                              padding: const EdgeInsets.all(24),
                              child: Image.asset(
                                'assets/images/image_placeholder.png',
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _PreviewText(_nameController.text, 'User Name'),
                        const Divider(color: AppColors.gold, height: 16),
                        _PreviewText(
                          _emailController.text,
                          'example@email.com',
                        ),
                        const Divider(color: AppColors.gold, height: 16),
                        _PreviewText(_phoneController.text, '+200000000000'),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              AppTextField(
                controller: _nameController,
                hint: 'Enter User Name',
                validator: (v) => _required(v, 'the user name'),
              ),
              const SizedBox(height: 8),
              AppTextField(
                controller: _emailController,
                hint: 'Enter User Email',
                keyboardType: TextInputType.emailAddress,
                validator: _validateEmail,
              ),
              const SizedBox(height: 8),
              AppTextField(
                controller: _phoneController,
                hint: 'Enter User Phone',
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.done,
                validator: _validatePhone,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submit,
                child: const Text('Enter user', textAlign: TextAlign.center),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PreviewText extends StatelessWidget {
  final String value;
  final String placeholder;

  const _PreviewText(this.value, this.placeholder);

  @override
  Widget build(BuildContext context) {
    return Text(
      value.isEmpty ? placeholder : value,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(color: AppColors.gold, fontSize: 16),
    );
  }
}
