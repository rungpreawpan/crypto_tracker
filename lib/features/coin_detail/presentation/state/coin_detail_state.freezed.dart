// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'coin_detail_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CoinDetailState {

 CoinDetail? get coin; bool get isFavorite; bool get isOffline;
/// Create a copy of CoinDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CoinDetailStateCopyWith<CoinDetailState> get copyWith => _$CoinDetailStateCopyWithImpl<CoinDetailState>(this as CoinDetailState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CoinDetailState&&(identical(other.coin, coin) || other.coin == coin)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite)&&(identical(other.isOffline, isOffline) || other.isOffline == isOffline));
}


@override
int get hashCode => Object.hash(runtimeType,coin,isFavorite,isOffline);

@override
String toString() {
  return 'CoinDetailState(coin: $coin, isFavorite: $isFavorite, isOffline: $isOffline)';
}


}

/// @nodoc
abstract mixin class $CoinDetailStateCopyWith<$Res>  {
  factory $CoinDetailStateCopyWith(CoinDetailState value, $Res Function(CoinDetailState) _then) = _$CoinDetailStateCopyWithImpl;
@useResult
$Res call({
 CoinDetail? coin, bool isFavorite, bool isOffline
});




}
/// @nodoc
class _$CoinDetailStateCopyWithImpl<$Res>
    implements $CoinDetailStateCopyWith<$Res> {
  _$CoinDetailStateCopyWithImpl(this._self, this._then);

  final CoinDetailState _self;
  final $Res Function(CoinDetailState) _then;

/// Create a copy of CoinDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? coin = freezed,Object? isFavorite = null,Object? isOffline = null,}) {
  return _then(_self.copyWith(
coin: freezed == coin ? _self.coin : coin // ignore: cast_nullable_to_non_nullable
as CoinDetail?,isFavorite: null == isFavorite ? _self.isFavorite : isFavorite // ignore: cast_nullable_to_non_nullable
as bool,isOffline: null == isOffline ? _self.isOffline : isOffline // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CoinDetailState].
extension CoinDetailStatePatterns on CoinDetailState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( CoinDetailStateData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case CoinDetailStateData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( CoinDetailStateData value)  $default,){
final _that = this;
switch (_that) {
case CoinDetailStateData():
return $default(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( CoinDetailStateData value)?  $default,){
final _that = this;
switch (_that) {
case CoinDetailStateData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CoinDetail? coin,  bool isFavorite,  bool isOffline)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case CoinDetailStateData() when $default != null:
return $default(_that.coin,_that.isFavorite,_that.isOffline);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CoinDetail? coin,  bool isFavorite,  bool isOffline)  $default,) {final _that = this;
switch (_that) {
case CoinDetailStateData():
return $default(_that.coin,_that.isFavorite,_that.isOffline);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CoinDetail? coin,  bool isFavorite,  bool isOffline)?  $default,) {final _that = this;
switch (_that) {
case CoinDetailStateData() when $default != null:
return $default(_that.coin,_that.isFavorite,_that.isOffline);case _:
  return null;

}
}

}

/// @nodoc


class CoinDetailStateData implements CoinDetailState {
  const CoinDetailStateData({required this.coin, required this.isFavorite, required this.isOffline});
  

@override final  CoinDetail? coin;
@override final  bool isFavorite;
@override final  bool isOffline;

/// Create a copy of CoinDetailState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CoinDetailStateDataCopyWith<CoinDetailStateData> get copyWith => _$CoinDetailStateDataCopyWithImpl<CoinDetailStateData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CoinDetailStateData&&(identical(other.coin, coin) || other.coin == coin)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite)&&(identical(other.isOffline, isOffline) || other.isOffline == isOffline));
}


@override
int get hashCode => Object.hash(runtimeType,coin,isFavorite,isOffline);

@override
String toString() {
  return 'CoinDetailState(coin: $coin, isFavorite: $isFavorite, isOffline: $isOffline)';
}


}

/// @nodoc
abstract mixin class $CoinDetailStateDataCopyWith<$Res> implements $CoinDetailStateCopyWith<$Res> {
  factory $CoinDetailStateDataCopyWith(CoinDetailStateData value, $Res Function(CoinDetailStateData) _then) = _$CoinDetailStateDataCopyWithImpl;
@override @useResult
$Res call({
 CoinDetail? coin, bool isFavorite, bool isOffline
});




}
/// @nodoc
class _$CoinDetailStateDataCopyWithImpl<$Res>
    implements $CoinDetailStateDataCopyWith<$Res> {
  _$CoinDetailStateDataCopyWithImpl(this._self, this._then);

  final CoinDetailStateData _self;
  final $Res Function(CoinDetailStateData) _then;

/// Create a copy of CoinDetailState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? coin = freezed,Object? isFavorite = null,Object? isOffline = null,}) {
  return _then(CoinDetailStateData(
coin: freezed == coin ? _self.coin : coin // ignore: cast_nullable_to_non_nullable
as CoinDetail?,isFavorite: null == isFavorite ? _self.isFavorite : isFavorite // ignore: cast_nullable_to_non_nullable
as bool,isOffline: null == isOffline ? _self.isOffline : isOffline // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
