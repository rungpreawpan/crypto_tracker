// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'market_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MarketState {

 List<MarketCoin> get coins; List<MarketCoin> get filteredCoins; List<TrendingCoin> get trendingCoins; GlobalMarket? get globalMarket; String get searchQuery; int get currentPage; bool get isRefreshing; bool get isLoadingMore; bool get hasReachedEnd; bool get isOffline; String? get paginationError;
/// Create a copy of MarketState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MarketStateCopyWith<MarketState> get copyWith => _$MarketStateCopyWithImpl<MarketState>(this as MarketState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MarketState&&const DeepCollectionEquality().equals(other.coins, coins)&&const DeepCollectionEquality().equals(other.filteredCoins, filteredCoins)&&const DeepCollectionEquality().equals(other.trendingCoins, trendingCoins)&&(identical(other.globalMarket, globalMarket) || other.globalMarket == globalMarket)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.isRefreshing, isRefreshing) || other.isRefreshing == isRefreshing)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.hasReachedEnd, hasReachedEnd) || other.hasReachedEnd == hasReachedEnd)&&(identical(other.isOffline, isOffline) || other.isOffline == isOffline)&&(identical(other.paginationError, paginationError) || other.paginationError == paginationError));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(coins),const DeepCollectionEquality().hash(filteredCoins),const DeepCollectionEquality().hash(trendingCoins),globalMarket,searchQuery,currentPage,isRefreshing,isLoadingMore,hasReachedEnd,isOffline,paginationError);

@override
String toString() {
  return 'MarketState(coins: $coins, filteredCoins: $filteredCoins, trendingCoins: $trendingCoins, globalMarket: $globalMarket, searchQuery: $searchQuery, currentPage: $currentPage, isRefreshing: $isRefreshing, isLoadingMore: $isLoadingMore, hasReachedEnd: $hasReachedEnd, isOffline: $isOffline, paginationError: $paginationError)';
}


}

/// @nodoc
abstract mixin class $MarketStateCopyWith<$Res>  {
  factory $MarketStateCopyWith(MarketState value, $Res Function(MarketState) _then) = _$MarketStateCopyWithImpl;
@useResult
$Res call({
 List<MarketCoin> coins, List<MarketCoin> filteredCoins, List<TrendingCoin> trendingCoins, GlobalMarket? globalMarket, String searchQuery, int currentPage, bool isRefreshing, bool isLoadingMore, bool hasReachedEnd, bool isOffline, String? paginationError
});




}
/// @nodoc
class _$MarketStateCopyWithImpl<$Res>
    implements $MarketStateCopyWith<$Res> {
  _$MarketStateCopyWithImpl(this._self, this._then);

  final MarketState _self;
  final $Res Function(MarketState) _then;

/// Create a copy of MarketState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? coins = null,Object? filteredCoins = null,Object? trendingCoins = null,Object? globalMarket = freezed,Object? searchQuery = null,Object? currentPage = null,Object? isRefreshing = null,Object? isLoadingMore = null,Object? hasReachedEnd = null,Object? isOffline = null,Object? paginationError = freezed,}) {
  return _then(_self.copyWith(
coins: null == coins ? _self.coins : coins // ignore: cast_nullable_to_non_nullable
as List<MarketCoin>,filteredCoins: null == filteredCoins ? _self.filteredCoins : filteredCoins // ignore: cast_nullable_to_non_nullable
as List<MarketCoin>,trendingCoins: null == trendingCoins ? _self.trendingCoins : trendingCoins // ignore: cast_nullable_to_non_nullable
as List<TrendingCoin>,globalMarket: freezed == globalMarket ? _self.globalMarket : globalMarket // ignore: cast_nullable_to_non_nullable
as GlobalMarket?,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,isRefreshing: null == isRefreshing ? _self.isRefreshing : isRefreshing // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,hasReachedEnd: null == hasReachedEnd ? _self.hasReachedEnd : hasReachedEnd // ignore: cast_nullable_to_non_nullable
as bool,isOffline: null == isOffline ? _self.isOffline : isOffline // ignore: cast_nullable_to_non_nullable
as bool,paginationError: freezed == paginationError ? _self.paginationError : paginationError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MarketState].
extension MarketStatePatterns on MarketState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( MarketStateData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case MarketStateData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( MarketStateData value)  $default,){
final _that = this;
switch (_that) {
case MarketStateData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( MarketStateData value)?  $default,){
final _that = this;
switch (_that) {
case MarketStateData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<MarketCoin> coins,  List<MarketCoin> filteredCoins,  List<TrendingCoin> trendingCoins,  GlobalMarket? globalMarket,  String searchQuery,  int currentPage,  bool isRefreshing,  bool isLoadingMore,  bool hasReachedEnd,  bool isOffline,  String? paginationError)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case MarketStateData() when $default != null:
return $default(_that.coins,_that.filteredCoins,_that.trendingCoins,_that.globalMarket,_that.searchQuery,_that.currentPage,_that.isRefreshing,_that.isLoadingMore,_that.hasReachedEnd,_that.isOffline,_that.paginationError);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<MarketCoin> coins,  List<MarketCoin> filteredCoins,  List<TrendingCoin> trendingCoins,  GlobalMarket? globalMarket,  String searchQuery,  int currentPage,  bool isRefreshing,  bool isLoadingMore,  bool hasReachedEnd,  bool isOffline,  String? paginationError)  $default,) {final _that = this;
switch (_that) {
case MarketStateData():
return $default(_that.coins,_that.filteredCoins,_that.trendingCoins,_that.globalMarket,_that.searchQuery,_that.currentPage,_that.isRefreshing,_that.isLoadingMore,_that.hasReachedEnd,_that.isOffline,_that.paginationError);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<MarketCoin> coins,  List<MarketCoin> filteredCoins,  List<TrendingCoin> trendingCoins,  GlobalMarket? globalMarket,  String searchQuery,  int currentPage,  bool isRefreshing,  bool isLoadingMore,  bool hasReachedEnd,  bool isOffline,  String? paginationError)?  $default,) {final _that = this;
switch (_that) {
case MarketStateData() when $default != null:
return $default(_that.coins,_that.filteredCoins,_that.trendingCoins,_that.globalMarket,_that.searchQuery,_that.currentPage,_that.isRefreshing,_that.isLoadingMore,_that.hasReachedEnd,_that.isOffline,_that.paginationError);case _:
  return null;

}
}

}

/// @nodoc


class MarketStateData implements MarketState {
  const MarketStateData({required final  List<MarketCoin> coins, required final  List<MarketCoin> filteredCoins, required final  List<TrendingCoin> trendingCoins, required this.globalMarket, required this.searchQuery, required this.currentPage, required this.isRefreshing, required this.isLoadingMore, required this.hasReachedEnd, required this.isOffline, required this.paginationError}): _coins = coins,_filteredCoins = filteredCoins,_trendingCoins = trendingCoins;
  

 final  List<MarketCoin> _coins;
@override List<MarketCoin> get coins {
  if (_coins is EqualUnmodifiableListView) return _coins;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_coins);
}

 final  List<MarketCoin> _filteredCoins;
@override List<MarketCoin> get filteredCoins {
  if (_filteredCoins is EqualUnmodifiableListView) return _filteredCoins;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_filteredCoins);
}

 final  List<TrendingCoin> _trendingCoins;
@override List<TrendingCoin> get trendingCoins {
  if (_trendingCoins is EqualUnmodifiableListView) return _trendingCoins;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_trendingCoins);
}

@override final  GlobalMarket? globalMarket;
@override final  String searchQuery;
@override final  int currentPage;
@override final  bool isRefreshing;
@override final  bool isLoadingMore;
@override final  bool hasReachedEnd;
@override final  bool isOffline;
@override final  String? paginationError;

/// Create a copy of MarketState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MarketStateDataCopyWith<MarketStateData> get copyWith => _$MarketStateDataCopyWithImpl<MarketStateData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MarketStateData&&const DeepCollectionEquality().equals(other._coins, _coins)&&const DeepCollectionEquality().equals(other._filteredCoins, _filteredCoins)&&const DeepCollectionEquality().equals(other._trendingCoins, _trendingCoins)&&(identical(other.globalMarket, globalMarket) || other.globalMarket == globalMarket)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.isRefreshing, isRefreshing) || other.isRefreshing == isRefreshing)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.hasReachedEnd, hasReachedEnd) || other.hasReachedEnd == hasReachedEnd)&&(identical(other.isOffline, isOffline) || other.isOffline == isOffline)&&(identical(other.paginationError, paginationError) || other.paginationError == paginationError));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_coins),const DeepCollectionEquality().hash(_filteredCoins),const DeepCollectionEquality().hash(_trendingCoins),globalMarket,searchQuery,currentPage,isRefreshing,isLoadingMore,hasReachedEnd,isOffline,paginationError);

@override
String toString() {
  return 'MarketState(coins: $coins, filteredCoins: $filteredCoins, trendingCoins: $trendingCoins, globalMarket: $globalMarket, searchQuery: $searchQuery, currentPage: $currentPage, isRefreshing: $isRefreshing, isLoadingMore: $isLoadingMore, hasReachedEnd: $hasReachedEnd, isOffline: $isOffline, paginationError: $paginationError)';
}


}

/// @nodoc
abstract mixin class $MarketStateDataCopyWith<$Res> implements $MarketStateCopyWith<$Res> {
  factory $MarketStateDataCopyWith(MarketStateData value, $Res Function(MarketStateData) _then) = _$MarketStateDataCopyWithImpl;
@override @useResult
$Res call({
 List<MarketCoin> coins, List<MarketCoin> filteredCoins, List<TrendingCoin> trendingCoins, GlobalMarket? globalMarket, String searchQuery, int currentPage, bool isRefreshing, bool isLoadingMore, bool hasReachedEnd, bool isOffline, String? paginationError
});




}
/// @nodoc
class _$MarketStateDataCopyWithImpl<$Res>
    implements $MarketStateDataCopyWith<$Res> {
  _$MarketStateDataCopyWithImpl(this._self, this._then);

  final MarketStateData _self;
  final $Res Function(MarketStateData) _then;

/// Create a copy of MarketState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? coins = null,Object? filteredCoins = null,Object? trendingCoins = null,Object? globalMarket = freezed,Object? searchQuery = null,Object? currentPage = null,Object? isRefreshing = null,Object? isLoadingMore = null,Object? hasReachedEnd = null,Object? isOffline = null,Object? paginationError = freezed,}) {
  return _then(MarketStateData(
coins: null == coins ? _self._coins : coins // ignore: cast_nullable_to_non_nullable
as List<MarketCoin>,filteredCoins: null == filteredCoins ? _self._filteredCoins : filteredCoins // ignore: cast_nullable_to_non_nullable
as List<MarketCoin>,trendingCoins: null == trendingCoins ? _self._trendingCoins : trendingCoins // ignore: cast_nullable_to_non_nullable
as List<TrendingCoin>,globalMarket: freezed == globalMarket ? _self.globalMarket : globalMarket // ignore: cast_nullable_to_non_nullable
as GlobalMarket?,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,isRefreshing: null == isRefreshing ? _self.isRefreshing : isRefreshing // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,hasReachedEnd: null == hasReachedEnd ? _self.hasReachedEnd : hasReachedEnd // ignore: cast_nullable_to_non_nullable
as bool,isOffline: null == isOffline ? _self.isOffline : isOffline // ignore: cast_nullable_to_non_nullable
as bool,paginationError: freezed == paginationError ? _self.paginationError : paginationError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
