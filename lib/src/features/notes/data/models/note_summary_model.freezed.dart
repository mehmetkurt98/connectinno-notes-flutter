// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'note_summary_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

NoteSummaryModel _$NoteSummaryModelFromJson(Map<String, dynamic> json) {
  return _NoteSummaryModel.fromJson(json);
}

/// @nodoc
mixin _$NoteSummaryModel {
  String get summary => throw _privateConstructorUsedError;
  List<String> get keyPoints => throw _privateConstructorUsedError;
  int get wordCount => throw _privateConstructorUsedError;
  int get originalWordCount => throw _privateConstructorUsedError;

  /// Serializes this NoteSummaryModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NoteSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NoteSummaryModelCopyWith<NoteSummaryModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NoteSummaryModelCopyWith<$Res> {
  factory $NoteSummaryModelCopyWith(
          NoteSummaryModel value, $Res Function(NoteSummaryModel) then) =
      _$NoteSummaryModelCopyWithImpl<$Res, NoteSummaryModel>;
  @useResult
  $Res call(
      {String summary,
      List<String> keyPoints,
      int wordCount,
      int originalWordCount});
}

/// @nodoc
class _$NoteSummaryModelCopyWithImpl<$Res, $Val extends NoteSummaryModel>
    implements $NoteSummaryModelCopyWith<$Res> {
  _$NoteSummaryModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NoteSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? summary = null,
    Object? keyPoints = null,
    Object? wordCount = null,
    Object? originalWordCount = null,
  }) {
    return _then(_value.copyWith(
      summary: null == summary
          ? _value.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as String,
      keyPoints: null == keyPoints
          ? _value.keyPoints
          : keyPoints // ignore: cast_nullable_to_non_nullable
              as List<String>,
      wordCount: null == wordCount
          ? _value.wordCount
          : wordCount // ignore: cast_nullable_to_non_nullable
              as int,
      originalWordCount: null == originalWordCount
          ? _value.originalWordCount
          : originalWordCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NoteSummaryModelImplCopyWith<$Res>
    implements $NoteSummaryModelCopyWith<$Res> {
  factory _$$NoteSummaryModelImplCopyWith(_$NoteSummaryModelImpl value,
          $Res Function(_$NoteSummaryModelImpl) then) =
      __$$NoteSummaryModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String summary,
      List<String> keyPoints,
      int wordCount,
      int originalWordCount});
}

/// @nodoc
class __$$NoteSummaryModelImplCopyWithImpl<$Res>
    extends _$NoteSummaryModelCopyWithImpl<$Res, _$NoteSummaryModelImpl>
    implements _$$NoteSummaryModelImplCopyWith<$Res> {
  __$$NoteSummaryModelImplCopyWithImpl(_$NoteSummaryModelImpl _value,
      $Res Function(_$NoteSummaryModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of NoteSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? summary = null,
    Object? keyPoints = null,
    Object? wordCount = null,
    Object? originalWordCount = null,
  }) {
    return _then(_$NoteSummaryModelImpl(
      summary: null == summary
          ? _value.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as String,
      keyPoints: null == keyPoints
          ? _value._keyPoints
          : keyPoints // ignore: cast_nullable_to_non_nullable
              as List<String>,
      wordCount: null == wordCount
          ? _value.wordCount
          : wordCount // ignore: cast_nullable_to_non_nullable
              as int,
      originalWordCount: null == originalWordCount
          ? _value.originalWordCount
          : originalWordCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NoteSummaryModelImpl implements _NoteSummaryModel {
  const _$NoteSummaryModelImpl(
      {required this.summary,
      required final List<String> keyPoints,
      required this.wordCount,
      required this.originalWordCount})
      : _keyPoints = keyPoints;

  factory _$NoteSummaryModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$NoteSummaryModelImplFromJson(json);

  @override
  final String summary;
  final List<String> _keyPoints;
  @override
  List<String> get keyPoints {
    if (_keyPoints is EqualUnmodifiableListView) return _keyPoints;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_keyPoints);
  }

  @override
  final int wordCount;
  @override
  final int originalWordCount;

  @override
  String toString() {
    return 'NoteSummaryModel(summary: $summary, keyPoints: $keyPoints, wordCount: $wordCount, originalWordCount: $originalWordCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NoteSummaryModelImpl &&
            (identical(other.summary, summary) || other.summary == summary) &&
            const DeepCollectionEquality()
                .equals(other._keyPoints, _keyPoints) &&
            (identical(other.wordCount, wordCount) ||
                other.wordCount == wordCount) &&
            (identical(other.originalWordCount, originalWordCount) ||
                other.originalWordCount == originalWordCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      summary,
      const DeepCollectionEquality().hash(_keyPoints),
      wordCount,
      originalWordCount);

  /// Create a copy of NoteSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NoteSummaryModelImplCopyWith<_$NoteSummaryModelImpl> get copyWith =>
      __$$NoteSummaryModelImplCopyWithImpl<_$NoteSummaryModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NoteSummaryModelImplToJson(
      this,
    );
  }
}

abstract class _NoteSummaryModel implements NoteSummaryModel {
  const factory _NoteSummaryModel(
      {required final String summary,
      required final List<String> keyPoints,
      required final int wordCount,
      required final int originalWordCount}) = _$NoteSummaryModelImpl;

  factory _NoteSummaryModel.fromJson(Map<String, dynamic> json) =
      _$NoteSummaryModelImpl.fromJson;

  @override
  String get summary;
  @override
  List<String> get keyPoints;
  @override
  int get wordCount;
  @override
  int get originalWordCount;

  /// Create a copy of NoteSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NoteSummaryModelImplCopyWith<_$NoteSummaryModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

NoteSummaryRequest _$NoteSummaryRequestFromJson(Map<String, dynamic> json) {
  return _NoteSummaryRequest.fromJson(json);
}

/// @nodoc
mixin _$NoteSummaryRequest {
  String get content => throw _privateConstructorUsedError;

  /// Serializes this NoteSummaryRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NoteSummaryRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NoteSummaryRequestCopyWith<NoteSummaryRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NoteSummaryRequestCopyWith<$Res> {
  factory $NoteSummaryRequestCopyWith(
          NoteSummaryRequest value, $Res Function(NoteSummaryRequest) then) =
      _$NoteSummaryRequestCopyWithImpl<$Res, NoteSummaryRequest>;
  @useResult
  $Res call({String content});
}

/// @nodoc
class _$NoteSummaryRequestCopyWithImpl<$Res, $Val extends NoteSummaryRequest>
    implements $NoteSummaryRequestCopyWith<$Res> {
  _$NoteSummaryRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NoteSummaryRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? content = null,
  }) {
    return _then(_value.copyWith(
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NoteSummaryRequestImplCopyWith<$Res>
    implements $NoteSummaryRequestCopyWith<$Res> {
  factory _$$NoteSummaryRequestImplCopyWith(_$NoteSummaryRequestImpl value,
          $Res Function(_$NoteSummaryRequestImpl) then) =
      __$$NoteSummaryRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String content});
}

/// @nodoc
class __$$NoteSummaryRequestImplCopyWithImpl<$Res>
    extends _$NoteSummaryRequestCopyWithImpl<$Res, _$NoteSummaryRequestImpl>
    implements _$$NoteSummaryRequestImplCopyWith<$Res> {
  __$$NoteSummaryRequestImplCopyWithImpl(_$NoteSummaryRequestImpl _value,
      $Res Function(_$NoteSummaryRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of NoteSummaryRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? content = null,
  }) {
    return _then(_$NoteSummaryRequestImpl(
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NoteSummaryRequestImpl implements _NoteSummaryRequest {
  const _$NoteSummaryRequestImpl({required this.content});

  factory _$NoteSummaryRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$NoteSummaryRequestImplFromJson(json);

  @override
  final String content;

  @override
  String toString() {
    return 'NoteSummaryRequest(content: $content)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NoteSummaryRequestImpl &&
            (identical(other.content, content) || other.content == content));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, content);

  /// Create a copy of NoteSummaryRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NoteSummaryRequestImplCopyWith<_$NoteSummaryRequestImpl> get copyWith =>
      __$$NoteSummaryRequestImplCopyWithImpl<_$NoteSummaryRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NoteSummaryRequestImplToJson(
      this,
    );
  }
}

abstract class _NoteSummaryRequest implements NoteSummaryRequest {
  const factory _NoteSummaryRequest({required final String content}) =
      _$NoteSummaryRequestImpl;

  factory _NoteSummaryRequest.fromJson(Map<String, dynamic> json) =
      _$NoteSummaryRequestImpl.fromJson;

  @override
  String get content;

  /// Create a copy of NoteSummaryRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NoteSummaryRequestImplCopyWith<_$NoteSummaryRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
