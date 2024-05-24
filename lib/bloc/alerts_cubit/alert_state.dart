part of 'alert_cubit.dart';

class AlertState extends Equatable {
  final RequestState? getAlertState,  changeDataState;
  final AlertResponse? alertsResponse;

  const AlertState(
      {

      this.changeDataState,
      this.getAlertState,
      this.alertsResponse});

  AlertState copyWith({
    final RequestState? getAlertState,
    final RequestState? changeDataState,
    final AlertResponse? alertsResponse,
  
 
  }) =>
      AlertState(
        alertsResponse: alertsResponse ?? this.alertsResponse,
        getAlertState: getAlertState ?? this.getAlertState,
      
        
        changeDataState: changeDataState ?? this.changeDataState,
      );

  @override
  List<Object?> get props =>
      [getAlertState, alertsResponse,  changeDataState];
}
