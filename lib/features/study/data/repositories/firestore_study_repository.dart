import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:studymate_ai_app/features/study/domain/entities/study_item.dart';
import 'package:studymate_ai_app/features/study/domain/repositories/study_repository.dart';

class FirestoreStudyRepository implements StudyRepository {
  FirestoreStudyRepository({FirebaseFirestore? firestore, fb_auth.FirebaseAuth? auth})
      : _db = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? fb_auth.FirebaseAuth.instance;

  final FirebaseFirestore _db;
  final fb_auth.FirebaseAuth _auth;

  String get _uid => _auth.currentUser?.uid ?? (throw StateError('로그인이 필요합니다.'));

  CollectionReference<Map<String, dynamic>> get _col =>
      _db.collection('users').doc(_uid).collection('studies');

  StudyItem _fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? <String, dynamic>{};
    return StudyItem(
      id: doc.id,
      title: (data['title'] as String?) ?? '',
      progress: (data['progress'] as num?)?.toDouble() ?? 0.0,
      tags: (data['tags'] as List?)?.map((e) => e.toString()).toList(growable: false) ?? const <String>[],
      lastActivity: (data['lastActivity'] as Timestamp?)?.toDate() ?? DateTime.fromMillisecondsSinceEpoch(0),
    );
  }

  // Map helper kept for future batch writes (currently inline in methods)

  @override
  Future<List<StudyItem>> fetchAll() async {
    final snap = await _col.orderBy('lastActivity', descending: true).get();
    return snap.docs.map(_fromDoc).toList(growable: false);
  }

  @override
  Future<StudyItem> create({
    required String title,
    double progress = 0.0,
    List<String> tags = const [],
  }) async {
    final now = DateTime.now();
    final doc = await _col.add({
      'title': title,
      'progress': progress.clamp(0.0, 1.0).toDouble(),
      'tags': tags,
      'lastActivity': Timestamp.fromDate(now),
    });
    final created = await doc.get();
    return _fromDoc(created);
  }

  @override
  Future<StudyItem> update({
    required String id,
    String? title,
    double? progress,
    List<String>? tags,
  }) async {
    final now = DateTime.now();
    final payload = <String, dynamic>{
      if (title != null) 'title': title,
      if (progress != null) 'progress': progress.clamp(0.0, 1.0).toDouble(),
      if (tags != null) 'tags': tags,
      'lastActivity': Timestamp.fromDate(now),
    };
    await _col.doc(id).update(payload);
    final updated = await _col.doc(id).get();
    return _fromDoc(updated);
  }

  @override
  Future<void> delete(String id) async {
    await _col.doc(id).delete();
  }
}
