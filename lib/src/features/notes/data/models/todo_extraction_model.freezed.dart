// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'todo_extraction_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TodoExtractionRequest _$TodoExtractionRequestFromJson(
    Map<String, dynamic> json) {
  return _TodoExtractionRequest.fromJson(json);
}

/// @nodoc
mixin _$TodoExtractionRequest {
  String get content => throw _privateConstructorUsedError;

  /// Serializes this TodoExtractionRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TodoExtractionRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TodoExtractionRequestCopyWith<TodoExtractionRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TodoExtractionRequestCopyWith<$Res> {
  factory $TodoExtractionRequestCopyWith(TodoExtractionRequest value,
          $Res Function(TodoExtractionRequest) then) =
      _$TodoExtractionRequestCopyWithImpl<$Res, TodoExtractionRequest>;
  @useResult
  $Res call({String content});
}

/// @nodoc
class _$TodoExtractionRequestCopyWithImpl<$Res,
        $Val extends TodoExtractionRequest>
    implements $TodoExtractionRequestCopyWith<$Res> {
  _$TodoExtractionRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TodoExtractionRequest
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
abstract class _$$TodoExtractionRequestImplCopyWith<$Res>
    implements $TodoExtractionRequestCopyWith<$Res> {
  factory _$$TodoExtractionRequestImplCopyWith(
          _$TodoExtractionRequestImpl value,
          $Res Function(_$TodoExtractionRequestImpl) then) =
      __$$TodoExtractionRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String content});
}

/// @nodoc
class __$$TodoExtractionRequestImplCopyWithImpl<$Res>
    extends _$TodoExtractionRequestCopyWithImpl<$Res,
        _$TodoExtractionRequestImpl>
    implements _$$TodoExtractionRequestImplCopyWith<$Res> {
  __$$TodoExtractionRequestImplCopyWithImpl(_$TodoExtractionRequestImpl _value,
      $Res Function(_$TodoExtractionRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of TodoExtractionRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? content = null,
  }) {
    return _then(_$TodoExtractionRequestImpl(
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TodoExtractionRequestImpl implements _TodoExtractionRequest {
  const _$TodoExtractionRequestImpl({required this.content});

  factory _$TodoExtractionRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$TodoExtractionRequestImplFromJson(json);

  @override
  final String content;

  @override
  String toString() {
    return 'TodoExtractionRequest(content: $content)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TodoExtractionRequestImpl &&
            (identical(other.content, content) || other.content == content));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, content);

  /// Create a copy of TodoExtractionRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TodoExtractionRequestImplCopyWith<_$TodoExtractionRequestImpl>
      get copyWith => __$$TodoExtractionRequestImplCopyWithImpl<
          _$TodoExtractionRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TodoExtractionRequestImplToJson(
      this,
    );
  }
}

abstract class _TodoExtractionRequest implements TodoExtractionRequest {
  const factory _TodoExtractionRequest({required final String content}) =
      _$TodoExtractionRequestImpl;

  factory _TodoExtractionRequest.fromJson(Map<String, dynamic> json) =
      _$TodoExtractionRequestImpl.fromJson;

  @override
  String get content;

  /// Create a copy of TodoExtractionRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TodoExtractionRequestImplCopyWith<_$TodoExtractionRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}

TodoExtractionResponse _$TodoExtractionResponseFromJson(
    Map<String, dynamic> json) {
  return _TodoExtractionResponse.fromJson(json);
}

/// @nodoc
mixin _$TodoExtractionResponse {
  bool get hasTodos => throw _privateConstructorUsedError;
  List<String> get todos => throw _privateConstructorUsedError;
  String get originalContent => throw _privateConstructorUsedError;

  /// Serializes this TodoExtractionResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TodoExtractionResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TodoExtractionResponseCopyWith<TodoExtractionResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TodoExtractionResponseCopyWith<$Res> {
  factory $TodoExtractionResponseCopyWith(TodoExtractionResponse value,
          $Res Function(TodoExtractionResponse) then) =
      _$TodoExtractionResponseCopyWithImpl<$Res, TodoExtractionResponse>;
  @useResult
  $Res call({bool hasTodos, List<String> todos, String originalContent});
}

/// @nodoc
class _$TodoExtractionResponseCopyWithImpl<$Res,
        $Val extends TodoExtractionResponse>
    implements $TodoExtractionResponseCopyWith<$Res> {
  _$TodoExtractionResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TodoExtractionResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hasTodos = null,
    Object? todos = null,
    Object? originalContent = null,
  }) {
    return _then(_value.copyWith(
      hasTodos: null == hasTodos
          ? _value.hasTodos
          : hasTodos // ignore: cast_nullable_to_non_nullable
              as bool,
      todos: null == todos
          ? _value.todos
          : todos // ignore: cast_nullable_to_non_nullable
              as List<String>,
      originalContent: null == originalContent
          ? _value.originalContent
          : originalContent // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TodoExtractionResponseImplCopyWith<$Res>
    implements $TodoExtractionResponseCopyWith<$Res> {
  factory _$$TodoExtractionResponseImplCopyWith(
          _$TodoExtractionResponseImpl value,
          $Res Function(_$TodoExtractionResponseImpl) then) =
      __$$TodoExtractionResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool hasTodos, List<String> todos, String originalContent});
}

/// @nodoc
class __$$TodoExtractionResponseImplCopyWithImpl<$Res>
    extends _$TodoExtractionResponseCopyWithImpl<$Res,
        _$TodoExtractionResponseImpl>
    implements _$$TodoExtractionResponseImplCopyWith<$Res> {
  __$$TodoExtractionResponseImplCopyWithImpl(
      _$TodoExtractionResponseImpl _value,
      $Res Function(_$TodoExtractionResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of TodoExtractionResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hasTodos = null,
    Object? todos = null,
    Object? originalContent = null,
  }) {
    return _then(_$TodoExtractionResponseImpl(
      hasTodos: null == hasTodos
          ? _value.hasTodos
          : hasTodos // ignore: cast_nullable_to_non_nullable
              as bool,
      todos: null == todos
          ? _value._todos
          : todos // ignore: cast_nullable_to_non_nullable
              as List<String>,
      originalContent: null == originalContent
          ? _value.originalContent
          : originalContent // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TodoExtractionResponseImpl implements _TodoExtractionResponse {
  const _$TodoExtractionResponseImpl(
      {required this.hasTodos,
      required final List<String> todos,
      required this.originalContent})
      : _todos = todos;

  factory _$TodoExtractionResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$TodoExtractionResponseImplFromJson(json);

  @override
  final bool hasTodos;
  final List<String> _todos;
  @override
  List<String> get todos {
    if (_todos is EqualUnmodifiableListView) return _todos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_todos);
  }

  @override
  final String originalContent;

  @override
  String toString() {
    return 'TodoExtractionResponse(hasTodos: $hasTodos, todos: $todos, originalContent: $originalContent)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TodoExtractionResponseImpl &&
            (identical(other.hasTodos, hasTodos) ||
                other.hasTodos == hasTodos) &&
            const DeepCollectionEquality().equals(other._todos, _todos) &&
            (identical(other.originalContent, originalContent) ||
                other.originalContent == originalContent));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, hasTodos,
      const DeepCollectionEquality().hash(_todos), originalContent);

  /// Create a copy of TodoExtractionResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TodoExtractionResponseImplCopyWith<_$TodoExtractionResponseImpl>
      get copyWith => __$$TodoExtractionResponseImplCopyWithImpl<
          _$TodoExtractionResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TodoExtractionResponseImplToJson(
      this,
    );
  }
}

abstract class _TodoExtractionResponse implements TodoExtractionResponse {
  const factory _TodoExtractionResponse(
      {required final bool hasTodos,
      required final List<String> todos,
      required final String originalContent}) = _$TodoExtractionResponseImpl;

  factory _TodoExtractionResponse.fromJson(Map<String, dynamic> json) =
      _$TodoExtractionResponseImpl.fromJson;

  @override
  bool get hasTodos;
  @override
  List<String> get todos;
  @override
  String get originalContent;

  /// Create a copy of TodoExtractionResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TodoExtractionResponseImplCopyWith<_$TodoExtractionResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
