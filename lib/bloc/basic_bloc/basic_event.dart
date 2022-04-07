part of 'basic_bloc.dart';

abstract  class BasicEvent extends Equatable{
  const  BasicEvent();
}

class ButtonPressed extends BasicEvent{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}