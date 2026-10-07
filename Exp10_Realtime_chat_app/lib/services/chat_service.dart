import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/chat_message.dart';

class ChatService {
  final CollectionReference _messagesRef =
      FirebaseFirestore.instance.collection('messages');

  // CREATE: Store new message
  Future<void> sendMessage({
    required String text,
    required String sender,
    required String roomId,
  }) async {
    if (text.trim().isEmpty) return;
    await _messagesRef.add({
      'text': text.trim(),
      'sender': sender,
      'roomId': roomId,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  // READ: Realtime Stream of messages filtered by room
  Stream<List<ChatMessage>> getMessagesStream(String roomId) {
    return _messagesRef
        .where('roomId', isEqualTo: roomId)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ChatMessage.fromFirestore(doc))
            .toList());
  }

  // UPDATE: Edit message text
  Future<void> updateMessage(String docId, String updatedText) async {
    await _messagesRef.doc(docId).update({
      'text': updatedText.trim(),
      'isEdited': true,
    });
  }

  // DELETE: Remove message
  Future<void> deleteMessage(String docId) async {
    await _messagesRef.doc(docId).delete();
  }
}