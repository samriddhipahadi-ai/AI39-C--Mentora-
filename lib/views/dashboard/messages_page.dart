import 'package:flutter/material.dart';

import '../../services/profile_store.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../widgets/empty_state.dart';
import '../widgets/section_card.dart';
import 'widgets/page_header.dart';

/// "Messages" tab for both roles (Figma: "Messages." with two tabs).
/// Sending is a demo for now, the chat backend comes in a later sprint.
class MessagesPage extends StatefulWidget {
  const MessagesPage({super.key, required this.isTeacher});

  final bool isTeacher;

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  int _tab = 0; // 0 = student & teacher chat, 1 = Mentora AI
  final _recipient = TextEditingController();
  final _message = TextEditingController();
  final _question = TextEditingController();

  @override
  void dispose() {
    _recipient.dispose();
    _message.dispose();
    _question.dispose();
    super.dispose();
  }

  void _snack(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  void _sendChat() {
    if (!_recipient.text.contains('@') || _message.text.trim().isEmpty) {
      _snack('Enter the recipient email and a message.');
      return;
    }
    _message.clear();
    _snack('Chat will connect to the backend in a later sprint.');
  }

  void _askAi() {
    if (_question.text.trim().isEmpty) {
      _snack('Type a question first.');
      return;
    }
    _question.clear();
    _snack('Mentora AI will be connected in a later sprint.');
  }

  Widget _tabButton(String label, int index) {
    final selected = _tab == index;
    return Expanded(
      child: InkWell(
        onTap: () => setState(() => _tab = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: selected ? AppColors.navy : AppColors.border,
                width: 2,
              ),
            ),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: AppText.link
                .copyWith(color: selected ? AppColors.navy : AppColors.label),
          ),
        ),
      ),
    );
  }

  Widget _sendButton(VoidCallback onPressed) {
    return Align(
      alignment: Alignment.centerLeft,
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.navy,
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onPressed: onPressed,
        child: Text('Send', style: AppText.button),
      ),
    );
  }

  Widget _chatTab() {
    final other = widget.isTeacher ? 'student' : 'teacher';
    return SectionCard(
      title: 'Direct messages',
      subtitle: 'Private and role-verified',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EmptyState(
            title: 'Start a conversation',
            message: "Use the recipient's Mentora email to message a $other.",
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _recipient,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(hintText: '$other email'),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _message,
            decoration: const InputDecoration(hintText: 'Write a message...'),
          ),
          const SizedBox(height: 12),
          _sendButton(_sendChat),
        ],
      ),
    );
  }

  Widget _aiTab() {
    final name = ProfileStore.instance.current?.name ?? 'there';
    return SectionCard(
      title: 'Mentora AI',
      subtitle: 'Ready to help',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.pale,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              "Hi $name, I'm Mentora AI. Ask me for study planning, concept explanations or teaching ideas.",
              style: AppText.body,
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _question,
            decoration: const InputDecoration(hintText: 'Ask Mentora AI...'),
          ),
          const SizedBox(height: 12),
          _sendButton(_askAi),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final other = widget.isTeacher ? 'students' : 'teachers';
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
      children: [
        PageHeader(
          eyebrow: 'Communication',
          title: 'Messages.',
          subtitle: 'Chat directly with $other or ask Mentora AI.',
          centered: true,
        ),
        Row(
          children: [
            _tabButton('Student & teacher chat', 0),
            _tabButton('Mentora AI', 1),
          ],
        ),
        const SizedBox(height: 16),
        if (_tab == 0) _chatTab() else _aiTab(),
      ],
    );
  }
}