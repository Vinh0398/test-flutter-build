import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class UIState extends Equatable {
  const UIState();

  @override
  List<Object?> get props => [];
}

class UIInitialState extends UIState {}

class UILoadingState extends UIState {
  final bool loading;

  const UILoadingState(this.loading);

  @override
  List<Object?> get props => [loading];
}

class UIDataLoadedState<T> extends UIState {
  final T data;

  const UIDataLoadedState(this.data);

  @override
  List<Object?> get props => [data];
}

class UIEventDoneState<T> extends UIState {
  final T? data;

  const UIEventDoneState({this.data});

  @override
  List<Object?> get props => [data];
}

class UIErrorState extends UIState {
  final Exception error;

  const UIErrorState(this.error);

  @override
  List<Object?> get props => [error];
}