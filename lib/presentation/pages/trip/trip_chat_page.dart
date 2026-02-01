import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/services/chat_service.dart';
import '../../../domain/entities/chat_message.dart';
import '../../../l10n/app_localizations.dart';
import '../../bloc/chat/chat_bloc.dart';

/// Página de chat en tiempo real con el conductor durante un viaje
class TripChatPage extends StatefulWidget {
  final String tripId;
  final String currentUserId;
  final String currentUserName;
  final String otherUserId;
  final String otherUserName;
  final String? otherUserPhoto;

  const TripChatPage({
    super.key,
    required this.tripId,
    required this.currentUserId,
    required this.currentUserName,
    required this.otherUserId,
    required this.otherUserName,
    this.otherUserPhoto,
  });

  @override
  State<TripChatPage> createState() => _TripChatPageState();
}

class _TripChatPageState extends State<TripChatPage> {
  late ChatBloc _chatBloc;
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _messageFocusNode = FocusNode();

  Timer? _typingTimer;
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    _chatBloc = ChatBloc(chatService: ChatService());
    _chatBloc.setUserInfo(
      currentUserId: widget.currentUserId,
      currentUserName: widget.currentUserName,
      otherUserId: widget.otherUserId,
    );
    _chatBloc.add(LoadChat(
      tripId: widget.tripId,
      currentUserId: widget.currentUserId,
    ));
  }

  @override
  void dispose() {
    _chatBloc.add(const CloseChat());
    _chatBloc.close();
    _messageController.dispose();
    _scrollController.dispose();
    _messageFocusNode.dispose();
    _typingTimer?.cancel();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      Future.delayed(const Duration(milliseconds: 100), () {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }

  void _onTextChanged(String text) {
    // Notificar que el usuario está escribiendo
    if (!_isTyping && text.isNotEmpty) {
      _isTyping = true;
      _chatBloc.add(const TypingStatusChanged(true));
    }

    // Resetear el timer de typing
    _typingTimer?.cancel();
    _typingTimer = Timer(const Duration(seconds: 2), () {
      if (_isTyping) {
        _isTyping = false;
        _chatBloc.add(const TypingStatusChanged(false));
      }
    });
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    _chatBloc.add(SendMessage(text: text));
    _messageController.clear();

    // Resetear estado de typing
    _isTyping = false;
    _typingTimer?.cancel();

    _scrollToBottom();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocProvider.value(
      value: _chatBloc,
      child: Scaffold(
        backgroundColor: AppTheme.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppTheme.surfaceColor,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppTheme.textPrimaryColor),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Row(
            children: [
              // Avatar del otro usuario
              CircleAvatar(
                radius: 18,
                backgroundColor: AppTheme.primaryLightColor,
                backgroundImage: widget.otherUserPhoto != null
                    ? NetworkImage(widget.otherUserPhoto!)
                    : null,
                child: widget.otherUserPhoto == null
                    ? Text(
                        widget.otherUserName.isNotEmpty
                            ? widget.otherUserName[0].toUpperCase()
                            : '?',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : null,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.otherUserName,
                      style: const TextStyle(
                        color: AppTheme.textPrimaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    BlocBuilder<ChatBloc, ChatState>(
                      builder: (context, state) {
                        if (state is ChatLoaded && state.otherUserTyping) {
                          return const Text(
                            'Escribiendo...',
                            style: TextStyle(
                              color: AppTheme.primaryLightColor,
                              fontSize: 12,
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            // Lista de mensajes
            Expanded(
              child: BlocConsumer<ChatBloc, ChatState>(
                listener: (context, state) {
                  if (state is ChatLoaded) {
                    _scrollToBottom();
                    // Marcar mensajes como leídos
                    _chatBloc.add(const MarkMessagesRead());
                  }
                },
                builder: (context, state) {
                  if (state is ChatLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppTheme.primaryLightColor,
                      ),
                    );
                  }

                  if (state is ChatError) {
                    return Center(
                      child: Text(
                        state.message,
                        style: const TextStyle(color: AppTheme.errorColor),
                      ),
                    );
                  }

                  if (state is ChatLoaded) {
                    if (state.messages.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.chat_bubble_outline,
                              size: 64,
                              color: AppTheme.textSecondaryColor,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              l10n.noMessages,
                              style: const TextStyle(
                                color: AppTheme.textSecondaryColor,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              l10n.startConversation,
                              style: const TextStyle(
                                color: AppTheme.textSecondaryColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.all(16),
                      itemCount: state.messages.length,
                      itemBuilder: (context, index) {
                        final message = state.messages[index];
                        final isMe = message.isMine(widget.currentUserId);
                        final isSystem = message.type == MessageType.system;

                        // Mostrar fecha si es el primer mensaje del día
                        Widget? dateHeader;
                        if (index == 0 ||
                            !_isSameDay(
                              state.messages[index - 1].timestamp,
                              message.timestamp,
                            )) {
                          dateHeader = _buildDateHeader(message.timestamp);
                        }

                        return Column(
                          children: [
                            if (dateHeader != null) dateHeader,
                            if (isSystem)
                              _buildSystemMessage(message)
                            else
                              _buildMessageBubble(message, isMe),
                          ],
                        );
                      },
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),

            // Input de mensaje
            Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: AppTheme.surfaceColor,
                border: Border(
                  top: BorderSide(color: AppTheme.dividerColor),
                ),
              ),
              child: SafeArea(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppTheme.backgroundColor,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: TextField(
                          controller: _messageController,
                          focusNode: _messageFocusNode,
                          style: const TextStyle(
                            color: AppTheme.textPrimaryColor,
                          ),
                          decoration: InputDecoration(
                            hintText: l10n.typeMessage,
                            hintStyle: const TextStyle(
                              color: AppTheme.textSecondaryColor,
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                          ),
                          textCapitalization: TextCapitalization.sentences,
                          maxLines: 4,
                          minLines: 1,
                          onChanged: _onTextChanged,
                          onSubmitted: (_) => _sendMessage(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: _sendMessage,
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: const BoxDecoration(
                          color: AppTheme.primaryLightColor,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.send,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateHeader(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final messageDate = DateTime(date.year, date.month, date.day);

    String text;
    if (messageDate == today) {
      text = 'Hoy';
    } else if (messageDate == today.subtract(const Duration(days: 1))) {
      text = 'Ayer';
    } else {
      text = '${date.day}/${date.month}/${date.year}';
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: AppTheme.surfaceColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            text,
            style: const TextStyle(
              color: AppTheme.textSecondaryColor,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSystemMessage(ChatMessage message) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: AppTheme.primaryLightColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            message.text,
            style: const TextStyle(
              color: AppTheme.primaryLightColor,
              fontSize: 12,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message, bool isMe) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isMe ? AppTheme.primaryLightColor : AppTheme.surfaceColor,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(isMe ? 16 : 4),
            bottomRight: Radius.circular(isMe ? 4 : 16),
          ),
        ),
        child: Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              message.text,
              style: TextStyle(
                color: isMe ? Colors.white : AppTheme.textPrimaryColor,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _formatTime(message.timestamp),
                  style: TextStyle(
                    color: isMe
                        ? Colors.white.withValues(alpha: 0.7)
                        : AppTheme.textSecondaryColor,
                    fontSize: 10,
                  ),
                ),
                if (isMe) ...[
                  const SizedBox(width: 4),
                  Icon(
                    message.read ? Icons.done_all : Icons.done,
                    size: 14,
                    color: message.read
                        ? Colors.white
                        : Colors.white.withValues(alpha: 0.7),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
