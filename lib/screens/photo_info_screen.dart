import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:photo_gallery_app/models/photo.dart';

class PhotoInfoScreen extends StatelessWidget {
  final Photo photo;
  const PhotoInfoScreen({super.key, required this.photo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 400,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: CachedNetworkImage(
                imageUrl: photo.url,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: Colors.grey[300],
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey[300],
                  child: const Icon(Icons.error, size: 48),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoSection(
                    icon: Icons.location_on,
                    title: 'Location',
                    content: photo.location,
                  ),
                  const SizedBox(height: 16),
                  _buildInfoSection(
                    icon: Icons.person,
                    title: 'Created By',
                    content: photo.createdBy,
                  ),
                  const SizedBox(height: 16),
                  _buildInfoSection(
                    icon: Icons.calendar_today,
                    title: 'Taken At',
                    content: DateFormat('MMMM dd, yyyy - HH:mm')
                        .format(photo.takenAtDate),
                  ),
                  const SizedBox(height: 16),
                  _buildInfoSection(
                    icon: Icons.calendar_today,
                    title: 'Created At',
                    content: DateFormat('MMMM dd, yyyy - HH:mm')
                        .format(photo.createdAtDate),
                  ),
                  const SizedBox(height: 16),
                  _buildInfoSection(
                    icon: Icons.description,
                    title: 'Description',
                    content: photo.description,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection({
    required IconData icon,
    required String title,
    required String content,
  }) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 20, color: Colors.blue),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              content,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
