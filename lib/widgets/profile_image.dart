import 'dart:convert';
import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  final String? imageBase64;
  final double size;
  final String fallbackText;

  const ProfileImage({
    Key? key,
    this.imageBase64,
    this.size = 40,
    required this.fallbackText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (imageBase64 != null && imageBase64!.isNotEmpty) {
      try {
        // Remove data:image/jpeg;base64, prefix if exists
        final cleanBase64 = imageBase64!.contains(',')
            ? imageBase64!.split(',')[1]
            : imageBase64!;
            
        return CircleAvatar(
          radius: size / 2,
          backgroundImage: MemoryImage(base64Decode(cleanBase64)),
        );
      } catch (e) {
        return _buildFallbackAvatar();
      }
    }
    return _buildFallbackAvatar();
  }

  Widget _buildFallbackAvatar() {
    return CircleAvatar(
      radius: size / 2,
      backgroundColor: Colors.blue,
      child: Text(
        _getInitials(fallbackText),
        style: TextStyle(
          color: Colors.white,
          fontSize: size * 0.4,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  String _getInitials(String text) {
    if (text.isEmpty) return '';
    final names = text.trim().split(' ');
    if (names.length >= 2) {
      return '${names[0][0]}${names[1][0]}'.toUpperCase();
    }
    return text[0].toUpperCase();
  }
}
