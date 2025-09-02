// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'study_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StudyItem {

 String get id; String get title; double get progress;// 0.0 ~ 1.0
 DateTime get lastActivity; List<String> get tags;
/// Create a copy of StudyItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StudyItemCopyWith<StudyItem> get copyWith => _$StudyItemCopyWithImpl<StudyItem>(this as StudyItem, _$identity);

  /// Serializes this StudyItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StudyItem&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.lastActivity, lastActivity) || other.lastActivity == lastActivity)&&const DeepCollectionEquality().equals(other.tags, tags));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,progress,lastActivity,const DeepCollectionEquality().hash(tags));

@override
String toString() {
  return 'StudyItem(id: $id, title: $title, progress: $progress, lastActivity: $lastActivity, tags: $tags)';
}


}

/// @nodoc
abstract mixin class $StudyItemCopyWith<$Res>  {
  factory $StudyItemCopyWith(StudyItem value, $Res Function(StudyItem) _then) = _$StudyItemCopyWithImpl;
@useResult
$Res call({
 String id, String title, double progress, DateTime lastActivity, List<String> tags
});




}
/// @nodoc
class _$StudyItemCopyWithImpl<$Res>
    implements $StudyItemCopyWith<$Res> {
  _$StudyItemCopyWithImpl(this._self, this._then);

  final StudyItem _self;
  final $Res Function(StudyItem) _then;

/// Create a copy of StudyItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? progress = null,Object? lastActivity = null,Object? tags = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as double,lastActivity: null == lastActivity ? _self.lastActivity : lastActivity // ignore: cast_nullable_to_non_nullable
as DateTime,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [StudyItem].
extension StudyItemPatterns on StudyItem {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StudyItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StudyItem() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StudyItem value)  $default,){
final _that = this;
switch (_that) {
case _StudyItem():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StudyItem value)?  $default,){
final _that = this;
switch (_that) {
case _StudyItem() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  double progress,  DateTime lastActivity,  List<String> tags)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StudyItem() when $default != null:
return $default(_that.id,_that.title,_that.progress,_that.lastActivity,_that.tags);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  double progress,  DateTime lastActivity,  List<String> tags)  $default,) {final _that = this;
switch (_that) {
case _StudyItem():
return $default(_that.id,_that.title,_that.progress,_that.lastActivity,_that.tags);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  double progress,  DateTime lastActivity,  List<String> tags)?  $default,) {final _that = this;
switch (_that) {
case _StudyItem() when $default != null:
return $default(_that.id,_that.title,_that.progress,_that.lastActivity,_that.tags);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StudyItem implements StudyItem {
  const _StudyItem({required this.id, required this.title, this.progress = 0.0, required this.lastActivity, final  List<String> tags = const <String>[]}): _tags = tags;
  factory _StudyItem.fromJson(Map<String, dynamic> json) => _$StudyItemFromJson(json);

@override final  String id;
@override final  String title;
@override@JsonKey() final  double progress;
// 0.0 ~ 1.0
@override final  DateTime lastActivity;
 final  List<String> _tags;
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}


/// Create a copy of StudyItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StudyItemCopyWith<_StudyItem> get copyWith => __$StudyItemCopyWithImpl<_StudyItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StudyItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StudyItem&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.lastActivity, lastActivity) || other.lastActivity == lastActivity)&&const DeepCollectionEquality().equals(other._tags, _tags));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,progress,lastActivity,const DeepCollectionEquality().hash(_tags));

@override
String toString() {
  return 'StudyItem(id: $id, title: $title, progress: $progress, lastActivity: $lastActivity, tags: $tags)';
}


}

/// @nodoc
abstract mixin class _$StudyItemCopyWith<$Res> implements $StudyItemCopyWith<$Res> {
  factory _$StudyItemCopyWith(_StudyItem value, $Res Function(_StudyItem) _then) = __$StudyItemCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, double progress, DateTime lastActivity, List<String> tags
});




}
/// @nodoc
class __$StudyItemCopyWithImpl<$Res>
    implements _$StudyItemCopyWith<$Res> {
  __$StudyItemCopyWithImpl(this._self, this._then);

  final _StudyItem _self;
  final $Res Function(_StudyItem) _then;

/// Create a copy of StudyItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? progress = null,Object? lastActivity = null,Object? tags = null,}) {
  return _then(_StudyItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as double,lastActivity: null == lastActivity ? _self.lastActivity : lastActivity // ignore: cast_nullable_to_non_nullable
as DateTime,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
