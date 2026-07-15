// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_webview.state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppWebviewState {

 double get loadingPercentage; String get title; bool get canGoBack; bool get canGoForward; int get scrollY;
/// Create a copy of AppWebviewState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppWebviewStateCopyWith<AppWebviewState> get copyWith => _$AppWebviewStateCopyWithImpl<AppWebviewState>(this as AppWebviewState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppWebviewState&&(identical(other.loadingPercentage, loadingPercentage) || other.loadingPercentage == loadingPercentage)&&(identical(other.title, title) || other.title == title)&&(identical(other.canGoBack, canGoBack) || other.canGoBack == canGoBack)&&(identical(other.canGoForward, canGoForward) || other.canGoForward == canGoForward)&&(identical(other.scrollY, scrollY) || other.scrollY == scrollY));
}


@override
int get hashCode => Object.hash(runtimeType,loadingPercentage,title,canGoBack,canGoForward,scrollY);

@override
String toString() {
  return 'AppWebviewState(loadingPercentage: $loadingPercentage, title: $title, canGoBack: $canGoBack, canGoForward: $canGoForward, scrollY: $scrollY)';
}


}

/// @nodoc
abstract mixin class $AppWebviewStateCopyWith<$Res>  {
  factory $AppWebviewStateCopyWith(AppWebviewState value, $Res Function(AppWebviewState) _then) = _$AppWebviewStateCopyWithImpl;
@useResult
$Res call({
 double loadingPercentage, String title, bool canGoBack, bool canGoForward, int scrollY
});




}
/// @nodoc
class _$AppWebviewStateCopyWithImpl<$Res>
    implements $AppWebviewStateCopyWith<$Res> {
  _$AppWebviewStateCopyWithImpl(this._self, this._then);

  final AppWebviewState _self;
  final $Res Function(AppWebviewState) _then;

/// Create a copy of AppWebviewState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? loadingPercentage = null,Object? title = null,Object? canGoBack = null,Object? canGoForward = null,Object? scrollY = null,}) {
  return _then(_self.copyWith(
loadingPercentage: null == loadingPercentage ? _self.loadingPercentage : loadingPercentage // ignore: cast_nullable_to_non_nullable
as double,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,canGoBack: null == canGoBack ? _self.canGoBack : canGoBack // ignore: cast_nullable_to_non_nullable
as bool,canGoForward: null == canGoForward ? _self.canGoForward : canGoForward // ignore: cast_nullable_to_non_nullable
as bool,scrollY: null == scrollY ? _self.scrollY : scrollY // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [AppWebviewState].
extension AppWebviewStatePatterns on AppWebviewState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppWebviewState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppWebviewState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppWebviewState value)  $default,){
final _that = this;
switch (_that) {
case _AppWebviewState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppWebviewState value)?  $default,){
final _that = this;
switch (_that) {
case _AppWebviewState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double loadingPercentage,  String title,  bool canGoBack,  bool canGoForward,  int scrollY)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppWebviewState() when $default != null:
return $default(_that.loadingPercentage,_that.title,_that.canGoBack,_that.canGoForward,_that.scrollY);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double loadingPercentage,  String title,  bool canGoBack,  bool canGoForward,  int scrollY)  $default,) {final _that = this;
switch (_that) {
case _AppWebviewState():
return $default(_that.loadingPercentage,_that.title,_that.canGoBack,_that.canGoForward,_that.scrollY);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double loadingPercentage,  String title,  bool canGoBack,  bool canGoForward,  int scrollY)?  $default,) {final _that = this;
switch (_that) {
case _AppWebviewState() when $default != null:
return $default(_that.loadingPercentage,_that.title,_that.canGoBack,_that.canGoForward,_that.scrollY);case _:
  return null;

}
}

}

/// @nodoc


class _AppWebviewState implements AppWebviewState {
  const _AppWebviewState({this.loadingPercentage = 0.0, this.title = '', this.canGoBack = false, this.canGoForward = false, this.scrollY = 0});
  

@override@JsonKey() final  double loadingPercentage;
@override@JsonKey() final  String title;
@override@JsonKey() final  bool canGoBack;
@override@JsonKey() final  bool canGoForward;
@override@JsonKey() final  int scrollY;

/// Create a copy of AppWebviewState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppWebviewStateCopyWith<_AppWebviewState> get copyWith => __$AppWebviewStateCopyWithImpl<_AppWebviewState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppWebviewState&&(identical(other.loadingPercentage, loadingPercentage) || other.loadingPercentage == loadingPercentage)&&(identical(other.title, title) || other.title == title)&&(identical(other.canGoBack, canGoBack) || other.canGoBack == canGoBack)&&(identical(other.canGoForward, canGoForward) || other.canGoForward == canGoForward)&&(identical(other.scrollY, scrollY) || other.scrollY == scrollY));
}


@override
int get hashCode => Object.hash(runtimeType,loadingPercentage,title,canGoBack,canGoForward,scrollY);

@override
String toString() {
  return 'AppWebviewState(loadingPercentage: $loadingPercentage, title: $title, canGoBack: $canGoBack, canGoForward: $canGoForward, scrollY: $scrollY)';
}


}

/// @nodoc
abstract mixin class _$AppWebviewStateCopyWith<$Res> implements $AppWebviewStateCopyWith<$Res> {
  factory _$AppWebviewStateCopyWith(_AppWebviewState value, $Res Function(_AppWebviewState) _then) = __$AppWebviewStateCopyWithImpl;
@override @useResult
$Res call({
 double loadingPercentage, String title, bool canGoBack, bool canGoForward, int scrollY
});




}
/// @nodoc
class __$AppWebviewStateCopyWithImpl<$Res>
    implements _$AppWebviewStateCopyWith<$Res> {
  __$AppWebviewStateCopyWithImpl(this._self, this._then);

  final _AppWebviewState _self;
  final $Res Function(_AppWebviewState) _then;

/// Create a copy of AppWebviewState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? loadingPercentage = null,Object? title = null,Object? canGoBack = null,Object? canGoForward = null,Object? scrollY = null,}) {
  return _then(_AppWebviewState(
loadingPercentage: null == loadingPercentage ? _self.loadingPercentage : loadingPercentage // ignore: cast_nullable_to_non_nullable
as double,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,canGoBack: null == canGoBack ? _self.canGoBack : canGoBack // ignore: cast_nullable_to_non_nullable
as bool,canGoForward: null == canGoForward ? _self.canGoForward : canGoForward // ignore: cast_nullable_to_non_nullable
as bool,scrollY: null == scrollY ? _self.scrollY : scrollY // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
