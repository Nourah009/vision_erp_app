// screens/app/widgets/floating_messages_button.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vision_erp_app/screens/app/messages_popup.dart';
import 'package:vision_erp_app/screens/models/theme_model.dart';
import 'package:vision_erp_app/services/message_service.dart';
import 'package:vision_erp_app/services/localization_service.dart';

class FloatingMessagesButton extends StatefulWidget {
  const FloatingMessagesButton({super.key});

  @override
  State<FloatingMessagesButton> createState() => _FloatingMessagesButtonState();
}

class _FloatingMessagesButtonState extends State<FloatingMessagesButton> {
  final MessageService _messageService = MessageService();
  bool _showMessagesPopup = false;
  int _unreadCount = 0;

  @override
  void initState() {
    super.initState();
    _loadUnreadCount();
  }

  void _loadUnreadCount() {
    setState(() {
      _unreadCount = _messageService.getUnreadCount();
    });
  }

  void _toggleMessagesPopup() {
    setState(() {
      _showMessagesPopup = !_showMessagesPopup;
    });
  }

  void _onMessageRead() {
    _loadUnreadCount();
  }

  @override
  Widget build(BuildContext context) {
    final localizationService = Provider.of<LocalizationService>(context);
    final languageCode = localizationService.locale.languageCode;
    localizationService.setLocale(Locale(languageCode, languageCode == 'en' ? 'US' : 'SA'));
    return Stack(
      children: [
        // Floating Messages Button - فوق البوتوم بار مباشرة
        Positioned(
          bottom: 12, // فوق البوتوم بار
          right: languageCode == 'en' ? 20 : null,
          left: languageCode == 'en' ? null : 20,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: CircleAvatar(
              radius: 28,
              backgroundColor: AppColors.secondaryColor.withOpacity(0.9), // شفاف قليلاً
              child: IconButton(
                icon: const Icon(Icons.message_outlined, size: 24),
                color: Colors.white,
                onPressed: _toggleMessagesPopup,
              ),
            ),
          ),
        ),

        // Unread Messages Counter
        if (_unreadCount > 0)
          Positioned(
            bottom: 59, // فوق الزر مباشرة
            right: languageCode == 'en' ? 28 : null,
            left: languageCode == 'en' ? null : 28,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(12),
              ),
              constraints: const BoxConstraints(
                minWidth: 16,
                minHeight: 16,
              ),
              child: Text(
                _unreadCount > 99 ? '99+' : _unreadCount.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),

        // Messages Popup
        if (_showMessagesPopup)
          Positioned(
            bottom: 150, // فوق الزر
            right: languageCode == 'en' ? 20 : null,
            left: languageCode == 'en' ? null : 20,
            child: MessagesPopup(
              onClose: _toggleMessagesPopup,
              onMessageRead: _onMessageRead,
            ),
          ),
      ],
    );
  }
}