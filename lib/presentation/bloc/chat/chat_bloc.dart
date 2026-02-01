import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../core/services/chat_service.dart';
import '../../../domain/entities/chat_message.dart';

// Events
abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object?> get props => [];
}

class LoadChat extends ChatEvent {
  final String tripId;
  final String currentUserId;

  const LoadChat({required this.tripId, required this.currentUserId});

  @override
  List<Object?> get props => [tripId, currentUserId];
}

class SendMessage extends ChatEvent {
  final String text;

  const SendMessage({required this.text});

  @override
  List<Object?> get props => [text];
}

class MessagesUpdated extends ChatEvent {
  final List<ChatMessage> messages;

  const MessagesUpdated(this.messages);

  @override
  List<Object?> get props => [messages];
}

class TypingStatusChanged extends ChatEvent {
  final bool isTyping;

  const TypingStatusChanged(this.isTyping);

  @override
  List<Object?> get props => [isTyping];
}

class OtherUserTypingChanged extends ChatEvent {
  final bool isTyping;

  const OtherUserTypingChanged(this.isTyping);

  @override
  List<Object?> get props => [isTyping];
}

class MarkMessagesRead extends ChatEvent {
  const MarkMessagesRead();
}

class CloseChat extends ChatEvent {
  const CloseChat();
}

// States
abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object?> get props => [];
}

class ChatInitial extends ChatState {
  const ChatInitial();
}

class ChatLoading extends ChatState {
  const ChatLoading();
}

class ChatLoaded extends ChatState {
  final List<ChatMessage> messages;
  final bool otherUserTyping;
  final String tripId;
  final String currentUserId;

  const ChatLoaded({
    required this.messages,
    this.otherUserTyping = false,
    required this.tripId,
    required this.currentUserId,
  });

  @override
  List<Object?> get props => [messages, otherUserTyping, tripId, currentUserId];

  ChatLoaded copyWith({
    List<ChatMessage>? messages,
    bool? otherUserTyping,
    String? tripId,
    String? currentUserId,
  }) {
    return ChatLoaded(
      messages: messages ?? this.messages,
      otherUserTyping: otherUserTyping ?? this.otherUserTyping,
      tripId: tripId ?? this.tripId,
      currentUserId: currentUserId ?? this.currentUserId,
    );
  }
}

class ChatError extends ChatState {
  final String message;

  const ChatError(this.message);

  @override
  List<Object?> get props => [message];
}

// BLoC
class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatService _chatService;

  StreamSubscription<List<ChatMessage>>? _messagesSubscription;
  StreamSubscription<bool>? _typingSubscription;

  String? _tripId;
  String? _currentUserId;
  String? _currentUserName;
  String? _otherUserId;

  ChatBloc({
    ChatService? chatService,
  })  : _chatService = chatService ?? ChatService(),
        super(const ChatInitial()) {
    on<LoadChat>(_onLoadChat);
    on<SendMessage>(_onSendMessage);
    on<MessagesUpdated>(_onMessagesUpdated);
    on<TypingStatusChanged>(_onTypingStatusChanged);
    on<OtherUserTypingChanged>(_onOtherUserTypingChanged);
    on<MarkMessagesRead>(_onMarkMessagesRead);
    on<CloseChat>(_onCloseChat);
  }

  void setUserInfo({
    required String currentUserId,
    required String currentUserName,
    String? otherUserId,
  }) {
    _currentUserId = currentUserId;
    _currentUserName = currentUserName;
    _otherUserId = otherUserId;
  }

  Future<void> _onLoadChat(LoadChat event, Emitter<ChatState> emit) async {
    emit(const ChatLoading());

    _tripId = event.tripId;
    _currentUserId = event.currentUserId;

    // Suscribirse a mensajes en tiempo real
    _messagesSubscription?.cancel();
    _messagesSubscription = _chatService.getMessagesStream(event.tripId).listen(
      (messages) {
        add(MessagesUpdated(messages));
      },
      onError: (error) {
        emit(ChatError('Error cargando mensajes: $error'));
      },
    );

    // Suscribirse a estado de typing del otro usuario
    if (_otherUserId != null) {
      _typingSubscription?.cancel();
      _typingSubscription = _chatService
          .getTypingStream(event.tripId, _otherUserId!)
          .listen((isTyping) {
        add(OtherUserTypingChanged(isTyping));
      });
    }

    emit(ChatLoaded(
      messages: [],
      tripId: event.tripId,
      currentUserId: event.currentUserId,
    ));
  }

  Future<void> _onSendMessage(SendMessage event, Emitter<ChatState> emit) async {
    if (_tripId == null || _currentUserId == null) return;

    final currentState = state;
    if (currentState is! ChatLoaded) return;

    try {
      await _chatService.sendMessage(
        tripId: _tripId!,
        senderId: _currentUserId!,
        senderName: _currentUserName ?? 'Usuario',
        text: event.text,
      );

      // Resetear estado de typing
      await _chatService.setTyping(_tripId!, _currentUserId!, false);
    } catch (e) {
      emit(ChatError('Error enviando mensaje: $e'));
      emit(currentState);
    }
  }

  void _onMessagesUpdated(MessagesUpdated event, Emitter<ChatState> emit) {
    final currentState = state;
    if (currentState is ChatLoaded) {
      emit(currentState.copyWith(messages: event.messages));
    } else if (_tripId != null && _currentUserId != null) {
      emit(ChatLoaded(
        messages: event.messages,
        tripId: _tripId!,
        currentUserId: _currentUserId!,
      ));
    }
  }

  Future<void> _onTypingStatusChanged(
      TypingStatusChanged event, Emitter<ChatState> emit) async {
    if (_tripId == null || _currentUserId == null) return;

    await _chatService.setTyping(_tripId!, _currentUserId!, event.isTyping);
  }

  void _onOtherUserTypingChanged(
      OtherUserTypingChanged event, Emitter<ChatState> emit) {
    final currentState = state;
    if (currentState is ChatLoaded) {
      emit(currentState.copyWith(otherUserTyping: event.isTyping));
    }
  }

  Future<void> _onMarkMessagesRead(
      MarkMessagesRead event, Emitter<ChatState> emit) async {
    if (_tripId == null || _currentUserId == null) return;

    await _chatService.markMessagesAsRead(_tripId!, _currentUserId!);
  }

  void _onCloseChat(CloseChat event, Emitter<ChatState> emit) {
    _messagesSubscription?.cancel();
    _typingSubscription?.cancel();
    emit(const ChatInitial());
  }

  @override
  Future<void> close() {
    _messagesSubscription?.cancel();
    _typingSubscription?.cancel();
    return super.close();
  }
}
