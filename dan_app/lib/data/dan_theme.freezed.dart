// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'dan_theme.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods',
);

/// @nodoc
class _$DanThemeTearOff {
  const _$DanThemeTearOff();

  _DanTheme call({
    required String id,
    required String name,
    required int tasksCount,
  }) {
    return _DanTheme(
      id: id,
      name: name,
      tasksCount: tasksCount,
    );
  }
}

/// @nodoc
const $DanTheme = _$DanThemeTearOff();

/// @nodoc
mixin _$DanTheme {
  String get id => throw _privateConstructorUsedError;

  String get name => throw _privateConstructorUsedError;

  int get tasksCount => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DanThemeCopyWith<DanTheme> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DanThemeCopyWith<$Res> {
  factory $DanThemeCopyWith(DanTheme value, $Res Function(DanTheme) then) =
      _$DanThemeCopyWithImpl<$Res>;

  $Res call({String id, String name, int tasksCount});
}

/// @nodoc
class _$DanThemeCopyWithImpl<$Res> implements $DanThemeCopyWith<$Res> {
  _$DanThemeCopyWithImpl(this._value, this._then);

  final DanTheme _value;

  // ignore: unused_field
  final $Res Function(DanTheme) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? tasksCount = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      tasksCount: tasksCount == freezed
          ? _value.tasksCount
          : tasksCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$DanThemeCopyWith<$Res> implements $DanThemeCopyWith<$Res> {
  factory _$DanThemeCopyWith(_DanTheme value, $Res Function(_DanTheme) then) =
      __$DanThemeCopyWithImpl<$Res>;

  @override
  $Res call({String id, String name, int tasksCount});
}

/// @nodoc
class __$DanThemeCopyWithImpl<$Res> extends _$DanThemeCopyWithImpl<$Res>
    implements _$DanThemeCopyWith<$Res> {
  __$DanThemeCopyWithImpl(_DanTheme _value, $Res Function(_DanTheme) _then)
      : super(_value, (v) => _then(v as _DanTheme));

  @override
  _DanTheme get _value => super._value as _DanTheme;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? tasksCount = freezed,
  }) {
    return _then(
      _DanTheme(
        id: id == freezed
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                as String,
        name: name == freezed
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                as String,
        tasksCount: tasksCount == freezed
            ? _value.tasksCount
            : tasksCount // ignore: cast_nullable_to_non_nullable
                as int,
      ),
    );
  }
}

/// @nodoc
class _$_DanTheme with DiagnosticableTreeMixin implements _DanTheme {
  const _$_DanTheme(
      {required this.id, required this.name, required this.tasksCount,});

  @override
  final String id;
  @override
  final String name;
  @override
  final int tasksCount;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'DanTheme(id: $id, name: $name, tasksCount: $tasksCount)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'DanTheme'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('tasksCount', tasksCount));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _DanTheme &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.tasksCount, tasksCount) ||
                const DeepCollectionEquality()
                    .equals(other.tasksCount, tasksCount)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(tasksCount);

  @JsonKey(ignore: true)
  @override
  _$DanThemeCopyWith<_DanTheme> get copyWith =>
      __$DanThemeCopyWithImpl<_DanTheme>(
        this,
        _$identity,
      );
}

abstract class _DanTheme implements DanTheme {
  const factory _DanTheme(
      {required String id,
      required String name,
      required int tasksCount},) = _$_DanTheme;

  @override
  String get id => throw _privateConstructorUsedError;

  @override
  String get name => throw _privateConstructorUsedError;

  @override
  int get tasksCount => throw _privateConstructorUsedError;

  @override
  @JsonKey(ignore: true)
  _$DanThemeCopyWith<_DanTheme> get copyWith =>
      throw _privateConstructorUsedError;
}
