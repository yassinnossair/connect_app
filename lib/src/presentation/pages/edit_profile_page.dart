// lib/src/presentation/pages/edit_profile_page.dart

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:connect/src/domain/models/user_profile.dart';
import 'package:connect/src/domain/repositories/auth_repository.dart';
import 'package:connect/src/domain/repositories/profile_repository.dart';
import 'package:connect/src/presentation/bloc/profile/profile_bloc.dart';
import 'package:connect/src/presentation/bloc/profile/profile_event.dart';
import 'package:connect/src/presentation/bloc/profile/profile_state.dart';


// NEW CODE for all 3 files
class EditProfilePage extends StatelessWidget { // Or ViewProfilePage, or QrCodePage
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // The BlocProvider is gone. We just return the View widget directly.
    return const EditProfileView(); // Or ViewProfileView, or QrCodeView
  }
}

// REFACTORED: Converted to a StatefulWidget to handle TextEditingControllers.
// This is crucial for allowing the form fields to be updated when the user
// switches between profiles.
class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  // Create controllers for each text field.
  final _nameController = TextEditingController();
  final _titleController = TextEditingController();
  final _companyController = TextEditingController();

  @override
  void dispose() {
    // It's important to dispose of controllers to free up resources.
    _nameController.dispose();
    _titleController.dispose();
    _companyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      // This listener now has two jobs:
      // 1. Show SnackBars for save success/failure.
      // 2. Update the text controllers when the selected profile changes.
      listenWhen: (previous, current) =>
      previous.status != current.status ||
          previous.selectedProfileId != current.selectedProfileId,
      listener: (context, state) {
        if (state.status == ProfileStatus.success) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text('Profile saved successfully!'),
                backgroundColor: Colors.green,
              ),
            );
        } else if (state.status == ProfileStatus.failure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text('An error occurred.'),
                backgroundColor: Colors.red,
              ),
            );
        }

        // When the selected profile changes, update the text fields.
        if (state.selectedProfile != null) {
          _nameController.text = state.selectedProfile!.name;
          _titleController.text = state.selectedProfile!.title ?? '';
          _companyController.text = state.selectedProfile!.company ?? '';
        }
      },
      child: Scaffold(
        appBar: AppBar(

          title: const Text('Edit Profile'),
          actions: [
            // NEW: Button to create a new profile.
            IconButton(
              icon: const Icon(Icons.add_box_outlined),
              onPressed: () => _showCreateProfileDialog(context),
            ),
            BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                return state.status == ProfileStatus.loading
                    ? const Padding(
                  padding: EdgeInsets.only(right: 16.0),
                  child: Center(
                    child: SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(color: Colors.white),
                    ),
                  ),
                )
                    : IconButton(
                  icon: const Icon(Icons.save),
                  onPressed: () {
                    context.read<ProfileBloc>().add(ProfileSaved());
                  },
                );
              },
            ),
          ],
        ),
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            // Use selectedProfile which is a getter in our state.
            final selectedProfile = state.selectedProfile;

            if (selectedProfile == null) {
              return const Center(child: CircularProgressIndicator());
            }

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 20),
                    const _ProfileAvatar(),
                    const SizedBox(height: 24),
                    // NEW: Dropdown to switch between profiles.
                    const _ProfileSelectorDropdown(),
                    const SizedBox(height: 24),
                    const Divider(),
                    const SizedBox(height: 24),
                    // REFACTORED: TextFields now use controllers.
                    _buildTextField(
                      label: 'Profile Name',
                      controller: _nameController,
                      onChanged: (value) =>
                          context.read<ProfileBloc>().add(ProfileNameChanged(value)),
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      label: 'Title',
                      controller: _titleController,
                      onChanged: (value) =>
                          context.read<ProfileBloc>().add(ProfileTitleChanged(value)),
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      label: 'Company',
                      controller: _companyController,
                      onChanged: (value) =>
                          context.read<ProfileBloc>().add(ProfileCompanyChanged(value)),
                    ),
                    const SizedBox(height: 24),
                    const Divider(),
                    const SizedBox(height: 16),
                    _ProfessionalLinksSection(
                      links: selectedProfile.professionalLinks,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // REFACTORED: Helper now takes a controller and an onChanged callback.
  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required ValueChanged<String> onChanged,
  }) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  // NEW: Method to show the 'Create Profile' dialog.
  void _showCreateProfileDialog(BuildContext blocContext) {
    final nameController = TextEditingController();
    showDialog(
      context: blocContext,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Create New Profile'),
          content: TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Profile Name (e.g., Freelance)'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('CANCEL'),
            ),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isNotEmpty) {
                  blocContext
                      .read<ProfileBloc>()
                      .add(ProfileCreated(name: nameController.text));
                  Navigator.of(dialogContext).pop();
                }
              },
              child: const Text('CREATE'),
            ),
          ],
        );
      },
    );
  }
}

// NEW: A dedicated widget for the profile selection dropdown.
class _ProfileSelectorDropdown extends StatelessWidget {
  const _ProfileSelectorDropdown();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state.profiles.isEmpty) return const SizedBox.shrink();

        return DropdownButtonFormField<String>(
          value: state.selectedProfileId,
          decoration: InputDecoration(
            labelText: 'Active Profile',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          items: state.profiles.map((profile) {
            return DropdownMenuItem<String>(
              value: profile.id,
              child: Text(profile.name),
            );
          }).toList(),
          onChanged: (profileId) {
            if (profileId != null) {
              context.read<ProfileBloc>().add(ProfileSelected(profileId));
            }
          },
        );
      },
    );
  }
}


class _ProfileAvatar extends StatelessWidget {
  const _ProfileAvatar();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        // REFACTORED: Gets URL from the selected profile.
        final profilePictureUrl = state.selectedProfile?.profilePictureUrl;

        return Center(
          child: Stack(
            children: [
              CircleAvatar(
                radius: 64,
                backgroundImage: profilePictureUrl != null
                    ? NetworkImage(profilePictureUrl)
                    : null,
                child: profilePictureUrl == null
                    ? const Icon(Icons.person, size: 64)
                    : null,
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () async {
                    final picker = ImagePicker();
                    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

                    if (pickedFile != null && context.mounted) {
                      final imageFile = File(pickedFile.path);
                      context.read<ProfileBloc>().add(ProfilePictureChanged(imageFile));
                    }
                  },
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    child: const Icon(Icons.edit, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}


class _ProfessionalLinksSection extends StatelessWidget {
  const _ProfessionalLinksSection({required this.links});

  final List<Map<String, String>> links;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Professional Links',
          style: theme.textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        links.isEmpty
            ? Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: Text(
              'No links yet.',
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ),
        )
            : Column(
          children: links.map((link) => _LinkTile(link: link)).toList(),
        ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () async {
              final newLink = await showDialog<Map<String, String>>(
                context: context,
                builder: (_) => const _AddLinkDialog(),
              );
              if (newLink != null && context.mounted) {
                context.read<ProfileBloc>().add(ProfileLinkAdded(newLink));
              }
            },
            child: const Text('+ ADD LINK'),
          ),
        ),
      ],
    );
  }
}

class _LinkTile extends StatelessWidget {
  const _LinkTile({required this.link});

  final Map<String, String> link;

  @override
  Widget build(BuildContext context) {
    final type = link['type'] ?? 'Link';
    final url = link['url'] ?? '';

    return Card(
      margin: const EdgeInsets.only(bottom: 8.0),
      child: ListTile(
        title: Text(type),
        subtitle: Text(url, maxLines: 1, overflow: TextOverflow.ellipsis),
        trailing: IconButton(
          icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
          onPressed: () {
            context.read<ProfileBloc>().add(ProfileLinkRemoved(link));
          },
        ),
      ),
    );
  }
}

class _AddLinkDialog extends StatefulWidget {
  const _AddLinkDialog();

  @override
  State<_AddLinkDialog> createState() => _AddLinkDialogState();
}

class _AddLinkDialogState extends State<_AddLinkDialog> {
  final _typeController = TextEditingController();
  final _urlController = TextEditingController();

  @override
  void dispose() {
    _typeController.dispose();
    _urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Professional Link'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _typeController,
            decoration: const InputDecoration(labelText: 'Type (e.g., LinkedIn)'),
            textCapitalization: TextCapitalization.words,
          ),
          TextField(
            controller: _urlController,
            decoration: const InputDecoration(labelText: 'URL'),
            keyboardType: TextInputType.url,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('CANCEL'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_typeController.text.isNotEmpty &&
                _urlController.text.isNotEmpty) {
              final newLink = {
                'type': _typeController.text,
                'url': _urlController.text,
              };
              Navigator.of(context).pop(newLink);
            }
          },
          child: const Text('ADD'),
        ),
      ],
    );
  }
}